
#ifndef EQ4_FUNCTIONS_AS
#define EQ4_FUNCTIONS_AS

#include "EQ3_Manager.as";


/*
namespace EQ {
  EQ_ITEM::Item g_global_spawn_item = EQ_ITEM::NIL;
  EQ_ITEM::Item g_class_spawn_item = EQ_ITEM::NIL;
  EQ_ITEM::Item g_player_spawn_item = EQ_ITEM::NIL;
}//EQ
namespace EQ {
  void Set_global_spawn_item() {
  }
  void Set_class_spawn_item() {
  }
  void Set_player_spawn_item() {
  }
}//EQ
*/



namespace EQ {
  bool Make_new( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }

  bool Move_to_equip( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }

  bool Move_to_storage( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  
  bool Move_to_inventory( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  
  bool Move_to_world( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }

  bool Remove_from_equip( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }

  bool Remove_from_storage( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  
  bool Remove_from_inventory( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  
  bool Remove_from_world( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
}//EQ



#endif
