
#ifndef EQ4_KNIGHT_FUNCTIONS_AS
#define EQ4_KNIGHT_FUNCTIONS_AS

#include "EQ3_Manager.as"

#include "KnightCommon.as";
#include "RunnerCommon.as";
#include "Knocked.as";
#include "EmotesCommon.as";



namespace EQ {
  void Play_items_animation( CSprite@ _this ) {
    if( @_this.animation == null ) {
      print("!!!!!!!!!!!!! ERROR 1");
      return;
    }
    // Get The EQ-Item's Overlayer:
    CSpriteLayer@ sprite_layer = _this.getSpriteLayer("EQ_ITEM");// <--- !!!!!!!!!
    if( @sprite_layer == null ) {
      error("EQ ERROR: Getting The 'eq_item' CSpriteLayer Faild! ->'EQ_Item_anim_equip.as'->'Play_items_animation'");
      return;
    }    
    // Check If The Overlayer Has The Animation That The Class Is Playing:
    Animation@ sl_anim = sprite_layer.getAnimation( _this.animation.name );
    if( @sl_anim == null ) {
      // If Not, Copy It: (this happens once per animation, the first time it plays)
      print("!!!!!!!!!!!!! copy: "+ _this.animation.name );
      @sl_anim = sprite_layer.addAnimation( _this.animation.name,
					    _this.animation.time,
					    _this.animation.loop );
      for( int i = 0 ; i < _this.animation.getFramesCount() ; ++i )
	sl_anim.AddFrame( _this.animation.getFrame( i ));
    }
    // Make The EQ-Item Play The Same Animation As The Class Is Playing: 
    sprite_layer.SetAnimation( _this.animation.name );
  }
}//EQ



namespace EQ {
  void Set_fixed_frames( CSprite@ _this ) {
    // Get The EQ-Item's Overlayer:
    CSpriteLayer@ sprite_layer = _this.getSpriteLayer("EQ_ITEM");// <--- !!!!!!!!!
    if( @sprite_layer == null ) {
      error("EQ ERROR: Getting The 'eq_item' CSpriteLayer Faild! ->'EQ_Item_anim_equip.as'->'Play_items_animation'");
      return;
    }    
    CBlob@ blob = _this.getBlob();
    if( blob.hasTag("dead")) {
      Vec2f vel = blob.getVelocity();
      if( vel.y < -1.0f ) {
	//_this.SetFrameIndex( 1 );
	sprite_layer.SetFrameIndex( 1 );
      }
      else if( vel.y > 1.0f ) {
	//_this.SetFrameIndex( 3 );
	sprite_layer.SetFrameIndex( 3 );
      }
      else {
	//_this.SetFrameIndex( 2 );
	sprite_layer.SetFrameIndex( 2 );
      }
      return;
    }
    KnightInfo@ knight;
    if( !blob.get("knightInfo", @knight )) {
      error("EQ ERROR: Getting The 'knightInfo' Faild! ->'EQ_Item_anim_equip.as'->'Play_items_animation'");
      return;
    }
    bool walking = ( blob.isKeyPressed( key_left ) || blob.isKeyPressed( key_right ));
    // Get The Angle Of Aiming With Mouse:
    Vec2f vec;
    int direction = blob.getAimDirection( vec );
    if(( getKnocked( blob ) > 0 )|| blob.hasTag("seated")) {
    }
    else if(( knight.state == KnightStates::shielding )&&( ! walking )) {
      if( direction == 1 ) {
	//_this.animation.frame = 2;
	sprite_layer.animation.frame = 2;
      }
      else if( direction == -1 ) {
	if( vec.y > -0.97 ) {
	  //_this.animation.frame = 1;
	  sprite_layer.animation.frame = 1;
	}	
	else {
	  //_this.animation.frame = 3;
	  sprite_layer.animation.frame = 3;
	}	
      }	
      else {
	//_this.animation.frame = 0;
	sprite_layer.animation.frame = 0;
      }
    }
    else if(( knight.state == KnightStates::sword_drawn )&&( knight.swordTimer >= KnightVars::slash_charge )) {
      if( knight.swordTimer < KnightVars::slash_charge_level2 ) {
	//_this.animation.frame = 0;
	sprite_layer.animation.frame = 0;
      }
      else if( knight.swordTimer < KnightVars::slash_charge_limit ) {
	//_this.animation.frame = 1;
	sprite_layer.animation.frame = 1;
      }
    }
    else if(( knight.state == KnightStates::sword_power || knight.state == KnightStates::sword_power_super )&&( knight.swordTimer <= 1 )) {
      //_this.animation.SetFrameIndex( 0 );
      sprite_layer.animation.SetFrameIndex( 0 );
    }
    // In Air:
    else if(( ! blob.isOnGround() )&&( ! blob.isOnLadder())) {
      Vec2f vel = blob.getVelocity();
      RunnerMoveVars@ moveVars;
      if( !blob.get("moveVars", @moveVars )) {
	error("EQ ERROR: Getting The 'moveVars' Faild! ->'EQ_Item_anim_equip.as'->'Play_items_animation'");
	return;
      }
      if( ! (( vel.y < -0.0f )&& moveVars.walljumped )) {
	//_this.animation.timer = 0;
	sprite_layer.animation.timer = 0;
	if( vel.y < -1.5) {
	  //_this.animation.frame = 0;
	  sprite_layer.animation.frame = 0;
	}
	else if( vel.y > 1.5) {
	  //_this.animation.frame = 2;
	  sprite_layer.animation.frame = 2;
	}
	else {
	  //_this.animation.frame = 1;
	  sprite_layer.animation.frame = 1;
	}
      }
    }
    else if( walking || blob.isKeyPressed( key_down ) ||( blob.isOnLadder() && blob.isKeyPressed( key_up ))) {
    }
    else if( is_emote( blob, 255, true )) {
      //_this.animation.frame = 1 + direction;
      sprite_layer.animation.frame = 1 + direction;
    }
  }
}//EQ



#endif
