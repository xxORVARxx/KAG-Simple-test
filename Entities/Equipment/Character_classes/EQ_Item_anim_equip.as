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



void onTick( CSprite@ _this ) {
  CSpriteLayer@ eq_item = null;
  @eq_item = _this.getSpriteLayer("EQ_ITEM");
  if( @eq_item == null ) {
    error("EQ ERROR: Getting The 'eq_item' CSpriteLayer Faild! ->'EQ_Item_anim_equip.as'->'onTick'");
    return;
  }
  eq_item.SetAnimation( _this.animation ); 
}



/*
void onRender( CSprite@ _this ) {
}
*/



#endif
