
function Test-Something {
    [CmdletBinding()]
    
    param ()

    dynamicparam {
        Get-DynamicParameter -Type Category, Site
    }
    
    begin {

    }
    
    process {
        
    }
    
    end {
        
    }
}

$Test = @(
    'Pissträsk'
    'rövhäsm'
)

$Test | Set-Content -Path $SitesFile

Test-Something -Category Temp -Site rövhäsm



$GestioNetworkList = Get-GestioNetworkList

<# 
$GestioHostList    = Get-GestioHostList

$FirstFreeAddress = foreach ($item in $GestioNetworkList) {
    Get-GestioFirstFreeNetworkAddress -Ip $item.IP
}
#>

$FinalObject = foreach ($item in $GestioNetworkList) {

    if (-not ($null -eq $TMP)) {
        Clear-Variable TMP
    }

    $FirstAddress  = $item.IP | Get-GestioSerialHost
    $SecondAddress = $FirstAddress | Get-GestioSerialHost
    $ThirdAddress  = $SecondAddress | Get-GestioSerialHost

    $FirstFreeIP  = Get-GestioHost -Ip $FirstAddress
    $SecondFreeIP = Get-GestioHost -Ip $SecondAddress
    $ThirdFreeIP  = Get-GestioHost -Ip $ThirdAddress

    $FreeAddresses = Get-GestioFreeNetworkAddresses -Ip $item.IP | Select-Object -ExpandProperty freeAddress

    [PSCustomObject]@{
        Network                 = $item.IP
        NetworkName             = $GestioNetworkList | Where-Object {$_.IP -eq $item.IP} | Select-Object -ExpandProperty descr
        FirstIP                 = $FirstAddress
        FirstIPHostname         = $FirstFreeIP.hostname
        FirstIPDescription      = $FirstFreeIP.descr
        SecondIP                = $SecondAddress
        SecondIPHostname        = $SecondFreeIP.hostname
        SecondIPDescription     = $SecondFreeIP.descr
        ThirdIP                 = $ThirdAddress
        ThirdIPHostname         = $ThirdFreeIP.hostname
        ThirdIPDescription      = $ThirdFreeIP.descr
        FirstFreeIP             = $FreeAddresses[0]
        SecondFreeIP            = $FreeAddresses[1]
        ThirdFreeIP             = $FreeAddresses[2]
    }
}

$FinalObject | Export-Excel -Now