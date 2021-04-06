function Get-GestioSerialHost {

    process {
        $IPOctets          = $_.Split(".")
        [int]$NetworkStart = $IPOctets[3]
        $NetworkStart++
        $Address      = "$($IPOctets[0]).$($IPOctets[1]).$($IPOctets[2]).$($NetworkStart)"
    }
    
    end {return $Address}
}