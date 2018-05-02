$WebService = New-WebServiceProxy -Uri 'http://Server001:9080/imws/services/ImpactManager?wsdl' -Namespace "myBPPMDemo"
$Connect_Request = [myBPPMDemo.Connect]::new()
$Connect_Request.userName = "UserName"
$Connect_Request.password = "Password"
$Connect_Request.imname = "string_ts"
$Connect_Request.bufferType = "BMCII_BUFFER_MODE_NONE"
$WebService.Connect($Connect_Request).connectionId

$Send_Event = [myBPPMDemo.SendEvent]::new()
$Send_Event.connection  = $WS.Connect($Connect_Request).ConnectionId
$Send_Event.messageType = [myBPPMDemo.IMMessageType]::MSG_TYPE_MOD_EVENT
$Send_Event.messageClass = "MC_CELL_UNDEFINED_CLASS"
$Send_Event.timeout = 0

$NameValue1 = [myBPPMDemo.NameValue]::new() 
$Value1 = [myBPPMDemo.value]::new()
$Value1.Item = "mc.String_TS.1a7dc6c9.0"
$NameValue1.name  = "mc_ueid"
$NameValue1.value = $Value1
$NameValue1

$NameValue2 = [myBPPMDemo.NameValue]::new() 
$Value2 = [myBPPMDemo.value]::new()
$Value2.Item = "CLOSED"
$NameValue2.name  = "status"
$NameValue2.value = $Value2
$NameValue2

$Send_Event = [myBPPMDemo.SendEvent]::new()
$Send_Event.connection  = $WS.Connect($Connect_Request).ConnectionId
$Send_Event.messageType = [myBPPMDemo.IMMessageType]::MSG_TYPE_MOD_EVENT
$Send_Event.messageClass = "MC_CELL_UNDEFINED_CLASS"
$Send_Event.timeout = 0
$Event = [myBPPMDemo.Event]::new()
$Event.NameValue_element = @($NameValue1, $NameValue2)
$Event.subject= "Automation Update"
$Send_Event.message = $Event
$WS.SendEvent($Send_Event)

$Disconnect = [myBPPMDemo.Disconnect]::new()
$Disconnect.connection = $WS.Connect($Connect_Request).connectionId