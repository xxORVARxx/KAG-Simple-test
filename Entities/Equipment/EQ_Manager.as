
#ifndef EQ_MANAGER_AS
#define EQ_MANAGER_AS
 
#include "EQ_Interface.as"



namespace EQ {
  funcdef EQ::b_Item@ Factory_fptr();

  class Manager {
    // --- METHODS ---
    void Register( Factory_fptr@ _Foo, EQ_ITEM::Item _item, string _name ) {
      if( m_factory[_item] != null ) {
	error("ERROR: Registering The Item '"+ _name +"' More Than Once! -> 'EQ::Manager::Register'");
	return;
      }
      m_factory[_item] = _Foo;
      m_item_names[_item] = _name;
      m_item_ids.set( _name, _item );
    }
    EQ::b_Item@ Make_item( const EQ_ITEM::Item _id ) {
      Factory_fptr@ fptr = m_factory[_id];
      EQ::b_Item@ item = fptr();
      return item;
    }
    
    EQ_ITEM::Item Get_id( const string _name ) {
      int64 item = 0;
      m_item_ids.get( _name, item );
      return EQ_ITEM::Item(item);
    }
    string Get_name( const EQ_ITEM::Item _id ) {
      return m_item_names[_id];
    }
    
    // --- VARIABLES ---
    array<EQ::Factory_fptr@> m_factory( EQ_ITEM::END, null );
    array<EQ::i_Item@> m_items;
    array<string> m_item_names( EQ_ITEM::END, "" );
    dictionary m_item_ids;
  }
}//EQ



#endif



// Equip An Item
