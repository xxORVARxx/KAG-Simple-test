/*
 * list this file in the '.cfg' files for all the classes that can equip items
 *
 */

#ifndef EQ_ITEM_LOGIC_EQUIP_AS
#define EQ_ITEM_LOGIC_EQUIP_AS

#include "EQ_Equipment_systems.as"



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HOOKS FOR ALL CHARACTERS/CLASSES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void onInit( CBlob@ _this ) { 
  EQ::c_Equipment_systems equipment_systems( _this, EQ_CLASS::KNIGHT );
  _this.set("EQS", @equipment_systems );
  equipment_systems.Set_size( 3, 3 );
  equipment_systems.Add_slot( EQ_SLOT::NIL );
  equipment_systems.Add_slot( EQ_SLOT::HEAD );
  equipment_systems.Add_slot( EQ_SLOT::NIL );
  equipment_systems.Add_slot( EQ_SLOT::LEFT_ARM );
  equipment_systems.Add_slot( EQ_SLOT::BODY );
  equipment_systems.Add_slot( EQ_SLOT::RIGHT_ARM );
  equipment_systems.Add_slot( EQ_SLOT::NIL );
  equipment_systems.Add_slot( EQ_SLOT::FEET );
  equipment_systems.Add_slot( EQ_SLOT::NIL );

  for( uint i = 0 ; i <= 9 ; ++i ) {
    // Only Works When 'i' Is Between 0 And 99:
    string num = formatInt( i, '', ( i < 10 ? 1 : 2 ));
    AddIconToken("$EQM"+ num +"$", "Equipped_items_menu.png", Vec2f( 16, 16 ), i );
  }//for
}



void onTick( CBlob@ _this ) {
}



// The Function 'ClearGridMenusExceptInventory()' Is Call In 'KnightLogic.as' So This File
// Needs To Be Included After/Below 'KnightLogic.as' In The '@$scripts' Array, In 'Knight.cfg'.
// Otherwise The Equipment Menu Is Never Displayed!
void onCreateInventoryMenu( CBlob@ _this, CBlob@ _for_blob, CGridMenu@ _gridmenu ) {
  EQ::c_Equipment_systems@ eqs = null;
  _this.get("EQS", @eqs );
  if( @eqs == null ) {
    error("EQ ERROR: Failed To Get The 'Equipment-Systems'! ->'onCreateInventoryMenu'->'"+ getCurrentScriptName() +"'");
    return;
  }
  eqs.Show_equipment_menu( _gridmenu );
}



void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid ) {
  if( @blob == null || blob.getShape().vellen > 1.0f )
    return;

}



void onCommand( CBlob@ _this, u8 _cmd, CBitStream@ _params ) {
  EQ::c_Equipment_systems@ eqs = null;
  _this.get("EQS", @eqs );
  if( @eqs == null ) {
    error("EQ ERROR: Failed To Get The 'Equipment-Systems'! ->'onCommand'->'"+ getCurrentScriptName() +"'");
    return;
  }
  eqs.Command( _cmd, _params );
}



/*
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
*/


#endif
