function menu 
{
   
   [int]$repuesta= Read-Host "
    `n`####################################################################################################################
    `n`#                                                                                                                  #
    `n`#     La powershell tiene que estar en modo Administrador para poder realizar cambios con el siguente script       #
    `n`#                                                                                                                  #
    `n`#                                        Echo por @MisterSupr69 2023                                               #
    `n`#                                                                                                                  #
    `n`####################################################################################################################
    `n` Elige una opcion: 
    `n` 1: Habilitar Protocolo SMB1 (Requiere reinicio una vez ejecutado)
    `n` 2: Desabilitar Protocolo SMB2
    `n` 3: Habilita Protocolo SMB2
    `n` 4: Instalacion y configuracion carpeta scanner (creacion carpeta c:/scanner crea acceso directo escritorio y comparte carpeta SMB)
    `n` 5: Dejar de compartir la carpeta scanner
    `n` 6: Salir
    `n` Opcion"
   switch ($repuesta)
   {
       1{Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol}
       2{Set-SmbServerConfiguration -EnableSMB2Protocol $false}
       3{Set-SmbServerConfiguration -EnableSMB2Protocol $true}
       4{
           Set-NetFirewallRule -DisplayGroup "Compartir archivos e impresoras" -Enabled True
           New-Item -path c:\scanner -type directory
           CACLS "C:\scanner" /E /G Todos:F
           New-SmbShare -Name scanner -Path c:/scanner -FullAccess "Todos" 
           $WshShell = New-Object -comObject WScript.Shell 
           $shortcut = $WshShell.CreateShortcut("$Home\Desktop\scanner.lnk") 
           $Shortcut.TargetPath = "C:\scanner" 
           $Shortcut.Save()
       }
       5{Remove-SmbShare -Name scanner}
       6{exit}
       Default {Write-Host "Opcion no valida"}
    }
   
    
}

    do
    {
        clear
        menu
        Read-Host "Pulsa intro para seguir"
    }while ($true)
