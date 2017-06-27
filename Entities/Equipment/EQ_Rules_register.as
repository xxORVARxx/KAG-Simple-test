/*
 *  This has to heppen after the 'gamemode.cfg' is dond building all the '.as' files..
 *  so the best hook i found is 'onNewPlayerJoin'... to delay this to when everything is ready.
 */

#include "EQ4_Rules_functions.as"


// This will use the array 'EQ_ITEM::g_str' in 'EQ1_Types.as' to find all the items and send them a commend to register ther 'factory function' with the 'manager'.
void onNewPlayerJoin( CRules@ _this, CPlayer@ _player ) {
  _this.Tag("EQ_REGISTERED");
  _this.Sync("EQ_REGISTERED", true );
  print("EQ: Register All Items:");
  for( uint i = 0 ; i < EQ_ITEM::g_str.length() ; ++i ) {
    CBlob@ item = server_CreateBlob( EQ_ITEM::g_str[i] );
    item.SendCommand( EQ_CMD::REGISTER );
  }//for  
  _this.RemoveScript( getCurrentScriptName());
}



/*
void onTick( CRules@ _this ) {
  EQ::Manager@ eqm = null;
  _this.get("EQM", @eqm );
  if( @eqm == null ) {
    error("EQ ERROR: Failed To Get The Equipment Manager! ->''->''");
    return;
  }

  for( uint i = 0 ; i < EQ_ITEM::g_str.length() ; ++i ) {
    CBlob@ item = server_CreateBlobNoInit( EQ_ITEM::g_str[i] );
    item.SendCommand( EQ_CMD::REGISTER );
  }//for  
  
  const array<EQ::Factory_fptr@>@ fac_arr = eqm.Get_factory_array();
  if( @fac_arr == null ) {
    error("EQ ERROR: Failed To Get 'factory_array' from the Manager! ->''->''");
    return;
  }
  for( uint i = 0 ; i < fac_arr.length() ; ++i ) {

  }//for
  
}
*/
