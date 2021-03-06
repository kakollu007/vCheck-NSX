# Start of Settings
# End of Settings

# Controller Components
$nsxCtrls = Get-NsxController

if ($nsxCtrls | Where-Object {$_.upgradeAvailable -eq "true"})
{
    $NsxCtrlUpgradeTable = New-Object system.Data.DataTable "NSX Controller Upgrades"

    # Define Columns
    $cols = @()
    $cols += New-Object system.Data.DataColumn Name,([string])
    $cols += New-Object system.Data.DataColumn Version,([string])
    $cols += New-Object system.Data.DataColumn "Upgrade Available",([string])

    #Add the Columns
    foreach ($col in $cols) {$NsxCtrlUpgradeTable.columns.add($col)}

    # Enumerate through each controller and populate the table
    foreach ($ctrl in $nsxCtrls)
    {
        # Populate a row in the Table
        $row = $NsxCtrlUpgradeTable.NewRow()

        # Enter data in the row
        $row.Name = $ctrl.name
        $row.version = $ctrl.version
        $row."Upgrade Available" = $ctrl.upgradeAvailable

        # Add the row to the table
        $NsxCtrlUpgradeTable.Rows.Add($row)
    }

    # Display the Status Table
    $NsxCtrlUpgradeTable | Select-Object Name,Version,"Upgrade Available"
}

# Plugin Outputs
$PluginCategory = "NSX"
$Title = "NSX Controller Upgrade Availability"
$Header = "NSX Controller Upgrade Availability"
$Comments = "NSX Controller(s) are reporting upgrades are available"
$Display = "Table"
$Author = "David Hocking"
$PluginVersion = 0.2