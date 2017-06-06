
#ifndef EQ1_TYPES_AS
#define EQ1_TYPES_AS



// List all the EQ items here, both in the enum 'Item' and in the string 'g_str', with there right name as it is the ther .cfg files 
namespace EQ_ITEM {
  enum Item {
    NIL = -1, // VVVV---- HERE!
    TEST_GREEN,
    END
  }
  // The 'g_str' Have To Match The Blob Names In The '.cfg' Files!
    const array<string> g_str = { "TEST_GREEN" }; // VVVV---- HERE!
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
    KNIGHT  = 1 << 0,
    ARCHER  = 1 << 1,   
    BUILDER = 1 << 2,
    MIGRANT = 1 << 3,
    END     = 1 << 4
  }
}//EQ_CLASS



namespace EQ_STATE {
  enum State {
    NIL = -1,
    EQUIPT,
    STORAGE,
    WORLD,
    END
  }
    const array<string> g_str = { "EQUIPT",
				  "STORAGE",
				  "WORLD" };
}//EQ_STATE



namespace EQ_CMD {
  enum Cmd {
    NIL = -1,
    REGISTER,
    MAKE_NEW,
    MOVE_TO_EQUIP,
    MOVE_TO_STORAGE,
    MOVE_TO_INVENTORY,
    MOVE_TO_WORLD,
    REMOVE_FROM_EQUIP,
    REMOVE_FROM_STORAGE,
    REMOVE_FROM_INVENTORY,
    REMOVE_FROM_WORLD,
    KILL,
    END
  }
    const array<string> g_str = { "REGISTER",
				  "MAKE_NEW",
				  "MOVE_TO_EQUIP",
				  "MOVE_TO_STORAGE",
				  "MOVE_TO_INVENTORY",
				  "MOVE_TO_WORLD",
				  "REMOVE_FROM_EQUIP",
				  "REMOVE_FROM_STORAGE",
				  "REMOVE_FROM_INVENTORY",
				  "REMOVE_FROM_WORLD",
				  "KILL" };
}//EQ_CMD



namespace EQ_SLOT {
  /*
  EQ_SLOT::Slot Get_id( const string _name ) {
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
  */
  string Get_name( const EQ_SLOT::Slot _id ) {
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
}//EQ_SLOT



namespace EQ_CLASS {
  /*
  EQ_CLASS::Class Get_id( const string _name ) {
    if( _name == "knight" )
      return EQ_CLASS::KNIGHT;
    else if( _name == "archer" )
      return EQ_CLASS::ARCHER;
    else if( _name == "builder" )
      return EQ_CLASS::BUILDER;
    else if( _name == "migrant" )
      return EQ_CLASS::MIGRANT;
    return EQ_CLASS::END;
  }
  */
  string Get_name( const EQ_CLASS::Class _id ) {
    switch( _id ) {
    case EQ_CLASS::KNIGHT:
      return "knight";
    case EQ_CLASS::ARCHER:
      return "archer";
    case EQ_CLASS::BUILDER:
      return "builder";
    case EQ_CLASS::MIGRANT:
      return "migrant";
    }//switch
    return "";
  }
}//EQ_CLASS



#endif
