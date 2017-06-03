
#include "EQ1_Types.as"



void onNewPlayerJoin( CRules@ _this, CPlayer@ _player ) {
  print("EQ: Register All Items:");
  for( uint i = 0 ; i < EQ_ITEM::g_str.length() ; ++i ) {
    CBlob@ item = server_CreateBlob( EQ_ITEM::g_str[i] );
    item.SendCommand( EQ_CMD::REGISTER );
  }  
  _this.RemoveScript( getCurrentScriptName());
}
