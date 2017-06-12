/*
 * list this file in the '.cfg' files for all the classes that can equip items
 *
 */

#ifndef EQ_ITEM_ANIM_EQUIP_AS
#define EQ_ITEM_ANIM_EQUIP_AS

#include "EQ4_Item_functions.as"



void onInit( CSprite@ _this ) {
  _this.RemoveSpriteLayer("EQ_ITEM");
  CSpriteLayer@ eq_item = _this.addSpriteLayer( "EQ_ITEM",
						"Test_green.png",
						32, 32 );
  if( @eq_item != null ) {
    eq_item.SetOffset( Vec2f( 0, -4 ));
    eq_item.SetVisible( true );
  }
}



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



void onTick( CSprite@ _this ) {		       
  EQ::Play_items_animation( _this );
}



/*
void onRender( CSprite@ _this ) {
}
*/



#endif
