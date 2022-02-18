with Invoices_input as (
    select * from {{ ref('Invoices_input') }}
),

/* Overview of frequently used functions in connector transformations.
- Case statement
- Get first non-null value; used to assign a specific value if the value is NULL
- Timestamp based on only a date attribute
- Trim part of a value
- Assign boolean values
*/
Frequently_used_transforms as (
    select
        -- Case statement: based on the price, define whether the invoice is high value or low value.
        case
            when Invoices_input."Price" > 100
                then 'High value invoice'
            else 'Low value invoice'
        end as "Invoice_type",
        -- Get first non-null value: when there is no payment timestamp, give it the value 'No payment'.
        -- When using coalesce() all arguments should be of the same data type.
        coalesce({{ pm_utils.to_varchar('Invoices_input."Paid_at"') }}, 'No payment') as "Paid_at",
        -- Timestamp based on only a date attribute
        {{ pm_utils.timestamp_from_date('Invoices_input."Payment_due_date"') }} as "Payment_due_date_timestamp",
        -- Trim part of a value: get the user number, which is at the right from the '-' character.
        right(Invoices_input."Creator", len(Invoices_input."Creator") - charindex('-', Invoices_input."Creator")) as "User_number",
        -- Assign boolean values: boolean values are best stored as 0 and 1. Indicate with 0 and 1 whether the payment is done.
        case
            when Invoices_input."Paid_at" is null
                then 0
            else 1
        end as "Payment_done"
    from Invoices_input
)

select * from Frequently_used_transforms
