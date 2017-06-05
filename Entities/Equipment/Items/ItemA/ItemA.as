
#include "EQ4_Item_functions.as"



// Factory-Function:
EQ::b_Item@ Factory_function() {
  // Return THIS EQ-Item, But Disguised As 'EQ::b_Item' (base-class item):
  return EQ::c_Item_A();
}

// Command To Register Item's 'Factory-Function' With The EQ-Manager:
void onCommand( CBlob@ _this, u8 _cmd, CBitStream@ _params ) {
  // This Call Will Come From 'EQ_Rules_register.as' When The First Player Joins The Game:
  if( _cmd == EQ_CMD::REGISTER ) {
    EQ::Register_item( @Factory_function, EQ_ITEM::ITEM_A );
    _this.server_Die();
  }
}



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LOGIC FOR THIS EQ-ITEM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

namespace EQ {
  class c_Item_A : EQ::b_Item {
    // --- CONSTRUCTORS ---
    c_Item_A() {
      m_slots = EQ_SLOT::Slot(EQ_SLOT::HEAD | EQ_SLOT::BODY);
    }
    // --- METHODS ---
    void World_onInit( CBlob@ _this ) override {
      print("----------------FROM EQ::c_Item_A::World_onInit");
    }
    void World_onTick( CBlob@ _this ) override {
      print("----------------FROM EQ::c_Item_A::World_onTick"); 
    }

    
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
  }
}//EQ
