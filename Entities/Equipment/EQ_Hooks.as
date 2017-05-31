
#include "EQ_Functions.as"



void onInit( CRules@ _this ) {
  _this.Tag("EQ");
  EQ::Manager equipment_manager;
  _this.set("EQM", @equipment_manager );
}



void onShowMenu( CRules@ _this ) {

}
 
void onSetPlayer( CRules@ _this, CBlob@ _blob, CPlayer@ _player ) {

}

void onPlayerChangedTeam( CRules@ _this, CPlayer@ _player, u8 _oldteam, u8 _newteam ) {

}

void onPlayerDie( CRules@ _this, CPlayer@ _victim, CPlayer@ _attacker, u8 _customData ) {

}

void onPlayerLeave( CRules@ _this, CPlayer@ _player ) {

}
