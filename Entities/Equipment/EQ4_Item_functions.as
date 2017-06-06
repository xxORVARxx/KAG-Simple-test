
#ifndef EQ_ITEM_COMMON_AS
#define EQ_ITEM_COMMON_AS

#include "EQ3_Manager.as"



namespace EQ {
  void Register_item( EQ::Factory_fptr@ _Foo, EQ_ITEM::Item _item ) {
    print("EQ: Registereing Item: '"+ EQ_ITEM::g_str[_item] +"'...");
    EQ::Manager@ eqm = null;
    CRules@ rules = getRules();
    if( @rules == null || ! rules.hasTag("EQ")) {
      error("EQ ERROR: Getting The Rules Failed Or The Rules Don't Have The Tag 'EQ'! ->'EQ4_Item_functions.as'->'EQ::Register_item'");
      error("       ( remember to add 'EQ_Rules.as;' to 'scripts' in 'gamemode.cfg' )");
      return;
    }
    rules.get("EQM", @eqm );
    if( @eqm == null ) {
      error("EQ ERROR: Failed To Get The Equipment Manager! ->'EQ4_Item_functions.as'->'EQ::Register_item'");
      return;
    }
    if( ! eqm.Register( @_Foo, _item )) {
      error("EQ ERROR: Register Fail! ->'EQ4_Item_functions.as'->'EQ::Register_item'");
      return;
    }
    print("    Success...");
  }
}//EQ



namespace EQ {
  bool Getter( CBlob@ _this, CRules@ _rules, array<EQ::b_Item@>@ _items ) {
    @_rules = getRules();
    if( @_rules == null ) {
      error("EQ ERROR: Getting The Rules Failed! ->'EQ4_Item_functions.as'->'EQ::Getter'");
      return false;
    }
    // vvvvvvvv TEMP vvvvvvvv
    if( @_items == null )
      return false;
    // ^^^^^^^^^^^^^^^^^^^^^^
    /* // Items Dont Have "EQ_ITEMS" Yet!!!!!!!!!!!!!
    _this.get("EQ_ITEMS", _items );
    if( @_items == null ) {
      error("EQ ERROR: Failed To Get The Items! ->'EQ4_Item_functions.as'->'EQ::Getter'");
      return false;
    }
    */
    return true;
  }

  bool Get_rules( CBlob@ _this, CRules@ _rules ) {
    @_rules = getRules();
    if( @_rules == null ) {
      error("EQ ERROR: Getting The Rules Failed! ->'EQ4_Item_functions.as'->'EQ::Get_rules'");
      return false;
    }
    return true;
  }

  
}//EQ



#endif
