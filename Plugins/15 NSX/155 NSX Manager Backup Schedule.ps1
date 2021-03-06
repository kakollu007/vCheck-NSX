# Start of Settings
# Desired backup frequency, (DAILY, WEEKLY, HOURLY)
$desiredBackupFreq = "DAILY"
# End of Settings

# NSX Manager Backup Components
$nsxBackup = Get-NsxManagerBackup

# If there is no Backup schedule matching the desired frequency
if ($nsxBackup.backupFrequency.frequency -ne $desiredBackupFreq)

{
    $NsxManagerBackupTable = New-Object system.Data.DataTable "NSX Manager Backup Schedule"

    # Define Columns
    $cols = @()
    $cols += New-Object system.Data.DataColumn Protocol,([string])
    $cols += New-Object system.Data.DataColumn Frequency,([string])
    $cols += New-Object system.Data.DataColumn Target,([string])

    #Add the Columns
    foreach ($col in $cols) {$NsxManagerBackupTable.columns.add($col)}

    # Populate a row in the Table
    $row = $NsxManagerBackupTable.NewRow()

    # Enter data in the row
    $row.Protocol = $nsxBackup.ftpSettings.transferProtocol
    $row.Frequency = $nsxBackup.backupFrequency.frequency
    $row.Target = $nsxBackup.ftpSettings.hostNameIPAddress

    # Add the row to the table
    $NsxManagerBackupTable.Rows.Add($row)

    # Display the Backup Frequency Table
    $NsxManagerBackupTable | Select-Object Protocol,Frequency,Target
}

# Plugin Outputs
$PluginCategory = "NSX"
$Title = "NSX Manager Backup Schedule"
$Header = "NSX Manager Backup Schedule"
$Comments = "NSX Manager is not configured with $($desiredBackupFreq) backups"
$Display = "Table"
$Author = "David Hocking"
$PluginVersion = 0.2