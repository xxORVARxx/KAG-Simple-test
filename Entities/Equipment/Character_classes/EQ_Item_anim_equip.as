/*
 * list this file in the '.cfg' files for all the classes that can equip items
 *
 */

#ifndef EQ_ITEM_ANIM_EQUIP_AS
#define EQ_ITEM_ANIM_EQUIP_AS

#include "EQ4_Item_functions.as"



void onInit( CSprite@ _this ) {
  _this.RemoveSpriteLayer("EQ_ITEM");
  CSpriteLayer@ eq_item = _this.addSpriteLayer( "EQ_ITEM", "/../Mods/Simple_test/Entities/Equipment/Items/ItemA/ItemA.png", 32, 32 );
}

void onTick( CSprite@ _this ) {
  CSpriteLayer@ eq_item_layer = null;
  @eq_item_layer = _this.getSpriteLayer("EQ_ITEM");
  if( @eq_item_layer == null ) {
    error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return;
  }
  uint16 frame = _this.getFrame();
  eq_item_layer.SetFrame( frame );
    
}

void onRender( CSprite@ _this ) {
}



#endif
