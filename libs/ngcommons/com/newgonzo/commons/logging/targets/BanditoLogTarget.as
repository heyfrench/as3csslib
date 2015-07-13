package com.newgonzo.commons.logging.targets
{
	import com.newgonzo.commons.logging.logcentral.LogCentralTarget;

	public class BanditoLogTarget extends LogCentralTarget
	{
		public function BanditoLogTarget(sendConnectionId:String="_jirabandito_receiving", receiveConnectionId:String="_jirabandito_sending", logMethod:String="logMessage", infoMethod:String="logValue")
		{
			super(sendConnectionId, receiveConnectionId, logMethod, infoMethod);
		}
	}
}