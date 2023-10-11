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
    `n`####################################################################################################################
    `n`#                                                                                                                  #
    `n`#                                         OPCIONES_CARPETAS_SCANAER (1-7).                                         #
    `n`#                                                                                                                  #
    `n`####################################################################################################################
    `n` 1: Habilitar Protocolo SMB1 (Requiere reinicio una vez ejecutado).
    `n` 2: Desabilitar Protocolo SMB2.
    `n` 3: Habilita Protocolo SMB2.
    `n` 4: Instalacion y configuracion carpeta scanner (creacion carpeta c:/scanner crea acceso directo escritorio y comparte carpeta SMB).
    `n` 5: Modificacion registro (veryoneincludesanonymous=0,NoLmHash=1 y restrictnullsessaccess=0)Si da problemas para quitar uso compatido por passwod.
    `n` 6: Dejar de compartir la carpeta scanner.
    `n` 7: Ejecucion hostname (para saber nombre del equipo de red ponerlo en la impresora).
    `n`####################################################################################################################
    `n`#                                                                                                                  #
    `n`#                                         INSTALACIONES_APLICACIONES (8-12).                                       #
    `n`#                                                                                                                  #
    `n`####################################################################################################################
    `n` 8: Instalar INSTALACIOR CHOCO.
    `n` 9: Instalar TODO_APLICACONES.
    `n` 10: Instalar REMOTAS.
    `n` 11: Instalar TODO_SIN_ONLIOFFICE.
    `n` 12: BOORAR TODO.
    `n` 13: SALIR
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
       5{
         reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa /v everyoneincludesanonymous /t REG_DWORD /d 0 /f
         reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa /v NoLmHash /t REG_DWORD /d 1 /f
         reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters /v restrictnullsessaccess /t REG_DWORD /d 0 /f
         }
       6{Remove-SmbShare -Name scanner}
       7{hostname}
       8{
           Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))        
       }
       9{
           choco install -y googlechrome --ignore-checksums --force 
           choco install -y firefox --ignore-checksums --force 
           choco install -y winrar --ignore-checksums --force
           choco install -y open-shell --ignore-checksums --force
           choco install -y vlc-skins --ignore-checksums --force
           choco install -y gimp --ignore-checksums --force
           choco install -y adobereader --ignore-checksums --force
           choco install -y onlyoffice --ignore-checksums --force
           choco install -y audacity --ignore-checksums --force
           choco install -y imgburn --ignore-checksums --force
           choco install -y 7zip.install --ignore-checksums --force
           choco install -y teamviewer --ignore-checksums --force
           choco install -y anydesk --ignore-checksums --force
          
       }
       10{
           choco install -y teamviewer --ignore-checksums --force
           choco install -y anydesk --ignore-checksums --force
       }
       11{
           choco install -y googlechrome --ignore-checksums --force 
           choco install -y firefox --ignore-checksums --force 
           choco install -y winrar --ignore-checksums --force
           choco install -y open-shell --ignore-checksums --force
           choco install -y vlc-skins --ignore-checksums --force
           choco install -y gimp --ignore-checksums --force
           choco install -y adobereader --ignore-checksums --force
           choco install -y audacity --ignore-checksums --force
           choco install -y imgburn --ignore-checksums --force
           choco install -y 7zip.install --ignore-checksums --force
           choco install -y teamviewer --ignore-checksums --force
           choco install -y anydesk --ignore-checksums --force
       }
       12{
           choco  uninstall googlechrome --force
           choco  uninstall firefox --force 
           choco  uninstall winrar  --force 
           choco  uninstall open-shell --ignore-checksums --force 
           choco  uninstall vlc --ignore-checksums --force 
           choco  uninstall gimp --ignore-checksums --force 
           choco  uninstall adobereader --ignore-checksums --force 
           choco  uninstall onlyoffice --ignore-checksums --force 
           choco  uninstall audacity --ignore-checksums --force 
           choco  uninstall imgburn --ignore-checksums --force 
           choco  uninstall 7zip.install --ignore-checksums --force 
           choco  uninstall teamviewer --ignore-checksums --force 
           choco  uninstall anydesk --ignore-checksums --force 
       
       }
       13{exit}
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
