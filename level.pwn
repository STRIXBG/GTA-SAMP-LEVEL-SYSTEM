/*
		* Level System for GTA SA:MP *
		* Made by Daniel Andreev (sTrIx) *
		* You must have register system to save players' Stats *
*/

#include <a_samp>

#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_ORANGE 0xF97804FF
#define COLOR_WHITE 0xFFFFFFFF

//Main Variables - open

enum pInfo
{
	pExp,
	pLevel
}

new PlayerInfo[MAX_PLAYERS][pInfo];
new expRequirment = 3;

//Main Variables - close

//strtok - open
strtok(const string[], &index)
{
	new length=strlen(string);
	while ((index<length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset=index;
	new result[20];
	while ((index<length) && (string[index]>' ') && ((index - offset)<(sizeof(result) - 1)))
	{
		result[index - offset]=string[index];
		index++;
	}
	result[index - offset]=EOS;
	return result;
}
//strtok - close

stock GivePlayerLevel(playerid, level)
{
	PlayerInfo[playerid][pLevel] += level;
}

stock GetPlayerExp(playerid, exp)
{
	PlayerInfo[playerid][pExp] -= exp;
}

public OnFilterScriptInit()
{
	print("\n----------------------------------------------------------");
	print(" Level System for GTA SA:MP Made by sTrIx ( Daniel Andreev)");
	print("----------------------------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256];
	new tmp[256];
    new idx;
    cmd=strtok(cmdtext, idx);
	if(strcmp(cmd, "/buylevel", true)==0)
    {
  		new length = strlen(cmdtext);
 		while ((idx < length) && (cmdtext[idx] <= ' '))
 		{
			idx++;
 		}
 		new offset = idx;
 		new confirmText[256];
 		while ((idx < length) && ((idx - offset) < (sizeof(confirmText) - 1)))
 		{
		confirmText[idx - offset] = cmdtext[idx];
 		idx++;
 		}
 		confirmText[idx - offset] = EOS;
 	 	new string256[256];
 		new expForNextLevel = PlayerInfo[playerid][pLevel]+expRequirment;
 		if(!strlen(confirmText))
 		{
		SendClientMessage(playerid, COLOR_WHITE, "Usage: /buylevel [confirm]");
		return 1;
		}
		if(strcmp(confirmText, "confirm", true) != 0)
   		{
		if(PlayerInfo[playerid][pExp]<expForNextLevel)
		{
		format(string256,256,"You need %d Exp to level up!",expForNextLevel);
		SendClientMessage(playerid,COLOR_GRAD1,string256);
		return 1;
		}
		GivePlayerLevel(playerid,1);
		GetPlayerExp(playerid, expForNextLevel);
		new hisLevel = PlayerInfo[playerid][pLevel];
		format(string256,256,"Congrats! Your new level is %d!",hisLevel);
  		SendClientMessage(playerid,COLOR_ORANGE,string256);
  		}
		return 1;
	}
	return 0;
}
