
#include "EQ_Equipment.as"



namespace EQ {
  class c_Item_A : EQ::b_Item {
    // --- CONSTRUCTORS ---
    c_Item_A() {
      m_slots = EQ_SLOT::Slot(EQ_SLOT::HEAD | EQ_SLOT::BODY);
    }
    // --- METHODS ---
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
  }
}//EQ



// Factory Function:
EQ::b_Item@ Factory_function() {
  return EQ::c_Item_A();
}



void onInit( CBlob@ _this ) {
  _this.Tag("ItemA");
  EQ::Manager@ eqm = EQ::onInit( _this, @Factory_function, EQ_ITEM::ITEM_A, "ITEM_A" );
  EQ::b_Item@ item = eqm.Make_item( EQ_ITEM::ITEM_A );
}
