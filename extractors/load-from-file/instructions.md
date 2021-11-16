# Instructions

See for instructions about the `load-from-file` extraction method the [UiPath documentation](link to extraction methods page). 

## Configuration
Input files for this connector can be found in the `data.zip` in the sample_data folder. These are tab delimited .csv files. To load them using the `load-from-file` extraction method, make sure to extract the .zip and configure the source connection in CData Sync to point to the location of the files.

Use the following custom query when creating the job:
```
{
    REPLICATE [Raw_change_log];
    REPLICATE [Raw_invoices];
    REPLICATE [Raw_purchase_order_approvals];
    REPLICATE [Raw_purchase_orders];
    REPLICATE [Raw_purchase_orders_status];
    REPLICATE [Raw_users]
}
```

To run the extraction method, execute the script `extraction.ps1` in the scripts folder.
