
#include "EQ_Equipment.as"



namespace EQ {
  class c_Item_A : EQ::b_Item {
    // --- METHODS ---
    void Print_test() {
      print("---> c_Item_A");
    }
    EQ_SLOT::Slot Get_slot() {
      print("Form: EQ::c_Item_A.Get_slot()");
      return EQ_SLOT::LEFT_ARM;
    }
    // --- VARIABLES ---
  }
}//EQ



// Factory Function:
EQ::b_Item@ Factory_function() {
  return EQ::c_Item_A();
}



void onInit( CBlob@ _this ) {
  _this.Tag("ItemA");
  EQ::Manager@ eqm = EQ::onInit( _this );
  eqm.Register( @Factory_function, EQ_ITEM::ITEM_A, "ITEM_A" );

  EQ::b_Item@ item = eqm.Make_item( EQ_ITEM::ITEM_A );
  item.Print_test();
}
