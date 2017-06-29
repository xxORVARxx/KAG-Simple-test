/*
 * list this file in the '.cfg' files for all the classes that can equip items
 *
 */

#ifndef EQ_KNIGHT_ANIM_EQUIP_AS
#define EQ_KNIGHT_ANIM_EQUIP_AS

#include "EQ_Equipment_systems.as"




void onInit( CSprite@ _this ) {
  /*
  _this.RemoveSpriteLayer("EQ_ITEM");
  CSpriteLayer@ eq_item = _this.addSpriteLayer( "EQ_ITEM",
						"Test_green.png",
						32, 32 );
  if( @eq_item != null ) {
    eq_item.SetRelativeZ( 50.0f );
    eq_item.SetOffset( Vec2f( 0, -4 ));
    eq_item.SetVisible( true );
  }
*/
}



void onTick( CSprite@ _this ) {
    /*
  EQ::Play_items_animation( _this );
  EQ::Set_fixed_frames( _this );


    // Get The EQ-Item's Overlayer:
    CSpriteLayer@ sprite_layer = _this.getSpriteLayer("EQ_ITEM");// <--- !!!!!!!!!
    if( @sprite_layer == null ) {
      error("EQ ERROR: Getting The 'eq_item' CSpriteLayer Faild! ->'EQ_Item_anim_equip.as'->'Play_items_animation'");
      return;
    }    

    if( _this.animation.frame > 0 || sprite_layer.animation.frame > 0 ) {
  printInt("Class: ", _this.animation.frame );
  printInt("Item:  ", sprite_layer.animation.frame );
  print(" ");
    }
*/
}



/*
void onRender( CSprite@ _this ) {
}
*/



#endif
