/*
 *
 */

#ifndef EQ_EQUIPMENT_SYSTEMS_AS
#define EQ_EQUIPMENT_SYSTEMS_AS

#include "EQ4_Item_functions.as"



namespace EQ {
  class c_Slot {
    // --- CONSTRUCTORS ---
    c_Slot( uint _index, EQ_SLOT::Slot _slot ) {
      m_index = _index;
      m_slot = _slot;
    }
    // --- METHODS ---
    uint Get_index() {
      return m_index;
    }
    EQ_SLOT::Slot Get_slot() {
      return m_slot;
    }
    bool Fits( const uint _slot ) {
      return this.Fits( EQ_SLOT::Slot(_slot) );
    }
    bool Fits( const EQ_SLOT::Slot _slot ) {
      return ( m_slot & _slot ) != 0;
    }
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
    private EQ_SLOT::Slot m_slot;
    private uint m_index;
  }
}//EQ



namespace EQ {
  class c_Equipment_systems {
    // --- CONSTRUCTORS ---
    c_Equipment_systems( CBlob@ _this, EQ_CLASS::Class _class ) {
      @m_the_blob = @_this;
      m_class = _class;
      m_the_blob.addCommandID("EQM_EQUIPMENT_MENU");
      m_the_blob.addCommandID("EQM_STORAGE_MENU");
      m_the_blob.addCommandID("EQM_SLOT_SELECTED");
    }
    // --- METHODS ---
    void Set_size( uint _width, uint _height ) {
      m_equipment_menu_size.x = _width;
      m_equipment_menu_size.y = _height;
      m_equipment_menu_pos.x = 48.0f * ( m_equipment_menu_size.x > 4 ? m_equipment_menu_size.x / 2.0f : 2.0f ) + 4.0f;
      m_equipment_menu_pos.y = 48.0f * ( m_equipment_menu_size.y / 2.0f );
    }
    void Add_slot( EQ_SLOT::Slot _slot ) {
      m_slots.insertLast( EQ::c_Slot( m_slots.length(), _slot ));
      m_items_equipt.insertLast( null );
    }
    void Show_equipment_menu( CGridMenu@ _gridmenu ) {
      /*
      CBitStream params;
      params.write_string( _gridmenu.getName());
      m_the_blob.SendCommand( m_the_blob.getCommandID("EQM_EQUIPMENT_MENU"), params );
      */
      this.Equipment_menu( _gridmenu );
    }
    void Show_storage_menu( CGridMenu@ _gridmenu ) {
      /*
      CBitStream params;
      params.write_string( _gridmenu.getName());
      m_the_blob.SendCommand( m_the_blob.getCommandID("EQM_STORAGE_MENU"), params );
      */
      this.Storage_menu( _gridmenu );
    }
    void Command( u8 _cmd, CBitStream@ _params ) {
      if( _cmd == m_the_blob.getCommandID("EQM_EQUIPMENT_MENU")) {
	CGridMenu@ gridmenu = getGridMenuByName( _params.read_string());
	this.Equipment_menu( gridmenu );
      }
      else if( _cmd == m_the_blob.getCommandID("EQM_STORAGE_MENU")) {
	CGridMenu@ gridmenu = getGridMenuByName( _params.read_string());
	this.Storage_menu( gridmenu );
      }
      else if( _cmd == m_the_blob.getCommandID("EQM_SLOT_SELECTED")) {
	u8 i = _params.read_u8();
	printInt("Command: 'EQM_SLOT_SELECTED'   ------------------------ index: ", i );
      }
    }
    // --- PRIVATE-METHODS ---
    private void Equipment_menu( CGridMenu@ _gridmenu ) {
      if(( m_slots.length() == 0 )||( m_slots.length() != ( m_equipment_menu_size.x * m_equipment_menu_size.y ))) {
	error("EQ ERROR: The Menu Size Must Equal The Number Of Slots! ->'"+ getCurrentScriptName() +"'->'EQ::c_Equipment_systems::Equipment_menu'");
	return;
      }
      Vec2f pos( _gridmenu.getUpperLeftPosition().x - m_equipment_menu_pos.x,
		 _gridmenu.getUpperLeftPosition().y + m_equipment_menu_pos.y );
      CGridMenu@ menu = CreateGridMenu( pos, m_the_blob, m_equipment_menu_size, "Equipped Items" );
      if( @menu == null ) {
	error("EQ ERROR: Failed To Create Grid Menu! ->'"+ getCurrentScriptName() +"'->'EQ::c_Equipment_systems::Equipment_menu'");
	return;
      }
      menu.deleteAfterClick = false;
      for( uint i = 0 ; i < m_slots.length() ; ++i ) {
	CBitStream params;
	params.write_u8( i );
	// Only Works When 'i' Is Between 0 And 99:
	string num = formatInt( i, '', ( i < 10 ? 1 : 2 ));
	CGridButton@ button = null;
	if( m_slots[i].Get_slot() == EQ_SLOT::NIL ) {
	  // Slot Is Not Used:
	  @button = menu.AddButton("$EQM"+ num +"$",
				   "Equipped Items",
				   255 );
	  button.SetEnabled( false );
	}
	else if( @m_items_equipt[i] == null ) {
	  // Slot Is Empty:
	  @button = menu.AddButton("$EQM"+ num +"$",
				   EQ_SLOT::Get_name( m_slots[i].Get_slot()),
				   m_the_blob.getCommandID("EQM_SLOT_SELECTED"), params );
	  button.selectOneOnClick = true;
	  button.SetHoverText("Empty Slot");
	}
	else {
	  // Slot Has Item:
	  @button = menu.AddButton("$EQ_"+ EQ_ITEM::g_str[ m_items_equipt[i].Get_type() ] +"$",
				   EQ_ITEM::g_str[ m_items_equipt[i].Get_type() ],
				   m_the_blob.getCommandID("EQM_SLOT_SELECTED"), params );
	  button.SetHoverText( EQ_ITEM::g_str[ m_items_equipt[i].Get_type() ]);
	}
      }//for
    }
    private void Storage_menu( CGridMenu@ _gridmenu ) {
      Vec2f menu_size( 6, 6 );
      Vec2f pos( _gridmenu.getLowerRightPosition().x + ( 48.0f * ( menu_size.x / 2.0f )) + 4.0f,
		 _gridmenu.getUpperLeftPosition().y + ( 48.0f * ( menu_size.y / 2.0f )));
      CGridMenu@ menu = CreateGridMenu( pos, m_the_blob, menu_size, "Storage" );
    }
    // --- VARIABLES ---
    CBlob@ m_the_blob;
    private array<EQ::i_Item@> m_items_storage;
    private array<EQ::i_Item@> m_items_equipt;
    private array<EQ::c_Slot> m_slots;
    private EQ_CLASS::Class m_class;
    private Vec2f m_equipment_menu_size;
    private Vec2f m_equipment_menu_pos;
  }
}//EQ



#endif
