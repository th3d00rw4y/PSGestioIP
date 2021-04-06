function Export-GestioListFirstThreeFree {

    [CmdletBinding()]

    param (
        # Where to save the file
        [Parameter(
            Position  = 0,
            Mandatory = $false
        )]
        [string]
        $Path = $TTF,

        # What format to save
        [Parameter(
            Position  = 1,
            Mandatory = $false
        )]
        [ValidateSet(
            'CSV',
            'XLSX'
        )]
        [string]
        $Format
    )
    
    begin {
        $Component = $MyInvocation.MyCommand

        switch ($Format) {
            CSV  {$FileName = "$(Get-Date -Format yyyy-MM-dd)_GestioExport.csv"}
            XLSX {$FileName = "$(Get-Date -Format yyyy-MM-dd)_GestioExport.xlsx"}
        }
    }
    
    process {
        
        $GestioNetworkList = Get-GestioNetworkList

        $Counter = 1

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

            Write-Host "Entry $Counter/$($GestioNetworkList.Count) has been processed."
            $Counter++
        }        
    }
    
    end {
        
        switch ($Format) {
            CSV  {$FinalObject | ConvertTo-Csv -NoTypeInformation | Set-Content "$TTF\$FileName"}
            XLSX {

                $ExcelParams = @{
                    Path            = "$TTF\$FileName"
                    AutoSize        = $true
                    AutoFilter      = $true
                    TableStyle      = 'Medium6'
                    BoldTopRow      = $true
                }

                $FinalObject | Export-Excel @ExcelParams
            }
        }
    }
}