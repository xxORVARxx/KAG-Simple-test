
#ifndef EQ_INTERFACE_AS
#define EQ_INTERFACE_AS



namespace EQ_ITEM {
  enum Item {
    NIL = -1,
    ITEM_A,
    END
  }
}//EQ_ITEM



namespace EQ_SLOT {
  enum Slot {
    NIL = -1,
    HEAD,
    RIGHT_ARM,   
    LEFT_ARM,
    BODY,
    FEET,
    END
  }
}//EQ_SLOT



namespace EQ {
  // Interface Class:
  interface i_Item {
    // --- METHODS ---
    void Print_test();
    EQ_SLOT::Slot Get_slot();
    // --- VARIABLES ---
  }
}//EQ



namespace EQ {
  // Base Class:
  class b_Item : EQ::i_Item {
    // --- METHODS ---
    void Print_test() {
      print("---> b_Item");
    }
    EQ_SLOT::Slot Get_slot() {
      print("Form: EQ::c_Default_item.Get_slot()");
      return EQ_SLOT::NIL;
    }
    // --- VARIABLES ---
  };
}



namespace EQ {
  EQ_SLOT::Slot Get_slots_id( const string _name ) {
    if( _name == "HEAD" )
      return EQ_SLOT::HEAD;
    else if( _name == "RIGHT_ARM" )
      return EQ_SLOT::RIGHT_ARM;
    else if( _name == "LEFT_ARM" )
      return EQ_SLOT::LEFT_ARM;
    else if( _name == "BODY" )
      return EQ_SLOT::BODY;
    else if( _name == "FEET" )
      return EQ_SLOT::FEET;	
    return EQ_SLOT::END;
  }

  string Get_slots_name( const EQ_SLOT::Slot _id ) {
    switch( _id ) {
    case EQ_SLOT::HEAD:
      return "HEAD";
    case EQ_SLOT::RIGHT_ARM:
      return "RIGHT_ARM";
    case EQ_SLOT::LEFT_ARM:
      return "LEFT_ARM";
    case EQ_SLOT::BODY:
      return "BODY";
    case EQ_SLOT::FEET:
      return "FEET";
    }//switch
    return "";
  }
}//EQ



#endif
