
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
    NIL       = 0,
    HEAD      = 1 << 0,
    RIGHT_ARM = 1 << 1,   
    LEFT_ARM  = 1 << 2,
    BODY      = 1 << 3,
    FEET      = 1 << 4,
    END       = 1 << 5
  }
}//EQ_SLOT



namespace EQ_CLASS {
  enum Class {
    NIL     = 0,
    Knight  = 1 << 0,
    Archer  = 1 << 1,   
    Builder = 1 << 2,
    Migrant = 1 << 3,
    END     = 1 << 4
  }
}//EQ_CLASS



namespace EQ {
  // Interface Class:
  interface i_Item {
    // --- CONSTRUCTORS ---
    // --- METHODS ---
    uint Get_index();
    void Set_index( uint _i );
    EQ_SLOT::Slot Get_slots();
    EQ_CLASS::Class Get_classes();
    bool Fits_slot( const EQ_SLOT::Slot _slot );
    bool Fits_class( const EQ_CLASS::Class _class );
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
  }
}//EQ



namespace EQ {
  // Base Class:
  class b_Item : EQ::i_Item {
    // --- CONSTRUCTORS ---
    // --- METHODS ---
    uint Get_index() {
      return m_index;
    }
    void Set_index( uint _i ) {
      if( m_index == -1 )
	m_index = _i;
    }
    EQ_SLOT::Slot Get_slots() {
      return m_slots;
    }
    EQ_CLASS::Class Get_classes() {
      return m_classes;
    }
    bool Fits_slot( const uint _slot ) {
      return this.Fits_slot( EQ_SLOT::Slot(_slot) );
    }
    bool Fits_slot( const EQ_SLOT::Slot _slot ) {
      return ( m_slots & _slot ) != 0;
    }
    bool Fits_class( const uint _class ) {
      return this.Fits_class( _class );
    }
    bool Fits_class( const EQ_CLASS::Class _class ) {
      return ( m_classes & _class ) != 0;
    }
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
    private uint m_index = -1;
    EQ_SLOT::Slot m_slots = EQ_SLOT::NIL;
    EQ_CLASS::Class m_classes = EQ_CLASS::NIL;
  }
}//EQ



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
