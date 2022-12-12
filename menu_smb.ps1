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
    `n` 1: Habilitar Protocolo SMB1 (Requiere reinicio una vez ejecutado).
    `n` 2: Desabilitar Protocolo SMB2.
    `n` 3: Habilita Protocolo SMB2.
    `n` 4: Instalacion y configuración carpeta scanner (creacion carpeta c:/scanner crea acceso directo escritorio y comparte carpeta SMB).
    `n` 5: Modificacion registro (veryoneincludesanonymous=0,NoLmHash=1 y restrictnullsessaccess=0)Si da problemas para quitar uso compatido por contraseña.
    `n` 6: Dejar de compartir la carpeta scanner.
    `n` 7: Ejecucion hostname (para saber nombre del equipo de red ponerlo en la impresora).
    `n` 8: Salir.
    `n` Opción"
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
       5{
         reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa /v everyoneincludesanonymous /t REG_DWORD /d 0 /f
         reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa /v NoLmHash /t REG_DWORD /d 1 /f
         reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters /v restrictnullsessaccess /t REG_DWORD /d 0 /f
         }
       6{Remove-SmbShare -Name scanner}
       7{hostname}
       8{exit}
       Default {Write-Host "Opcion no valida"}
    }
   
    
}

do
{

        clear
        menu
        Read-Host "Pulsa intro para seguir"
    
}
while ($true)
