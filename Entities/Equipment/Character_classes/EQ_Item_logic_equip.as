/*
 * list this file in the '.cfg' files for all the classes that can equip items
 *
 */

#ifndef EQ_ITEM_LOGIC_EQUIP_AS
#define EQ_ITEM_LOGIC_EQUIP_AS

#include "EQ4_Item_functions.as"



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HOOKS FOR ALL CHARACTERS/CLASSES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void onInit( CBlob@ _this ) {
  CRules@ rules = null;
  array<EQ::b_Item@>@ items = null;
  // NOT GOOD!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if( ! EQ::Getter( _this, rules, items )) {
    error("EQ ERROR: In Getter ->'EQ4_Item_logic_equip.as'->'onInit'");
    return;
  }
  for( uint i = 0 ; i < items.length() ; ++i ) {
    if( items[i].Get_state() == EQ_STATE::WORLD )
      items[i];//._onInit( _this, rules );
    else 
      error("EQ ERROR: Expected 'EQ_STATE::WORLD' not 'EQ_STATE::"+ EQ_STATE::g_str[ items[i].Get_state() ] +"' For Item '"+ EQ_ITEM::g_str[ items[i].Get_type() ] +"'! ->'EQ4_Item_logic_equip.as'->'onInit'");
  }//for

}

void onTick( CBlob@ _this ) {
  CRules@ rules = null;
  array<EQ::b_Item@>@ items = null;
  if( ! EQ::Getter( _this, rules, items )) {
    error("EQ ERROR: In Getter ->'EQ_Item_logic_equip.as'->'onTick'");
    return;
  }
  for( uint i = 0 ; i < items.length() ; ++i ) {
    if( items[i].Get_state() == EQ_STATE::WORLD )
      items[i];//._onTick( _this, rules );
    else
      error("EQ ERROR: Expected 'EQ_STATE::WORLD' not 'EQ_STATE::"+ EQ_STATE::g_str[ items[i].Get_state() ] +"' For Item '"+ EQ_ITEM::g_str[ items[i].Get_type() ] +"'! ->'EQ4_Item_logic_equip.as'->'onTick'");
  }//for
}

void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point1, Vec2f _point2 ) {
}

f32 onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  return _damage;
}

void onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
}

void onHealthChange( CBlob@ _this, f32 _oldHealth ) {
}
 
void onDie( CBlob@ _this ) {
}



#endif
