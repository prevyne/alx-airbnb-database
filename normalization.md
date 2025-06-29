Database Normalization Analysis
This document details the process of reviewing the AirBnB clone database schema to ensure it adheres to the Third Normal Form (3NF).

Principles of Normalization
Normalization is the process of organizing columns and tables in a relational database to minimize data redundancy.

First Normal Form (1NF): Ensures that the table is a flat file with no repeating groups. Each cell must hold a single value, and each record must be unique.

Second Normal Form (2NF): Requires the database to be in 1NF. Additionally, all non-key attributes must be fully functionally dependent on the entire primary key. This rule applies to tables with composite primary keys.

Third Normal Form (3NF): Requires the database to be in 2NF. Additionally, all attributes must be dependent only on the primary key and not on any other non-key attribute. This means there should be no transitive dependencies.

Schema Review and Analysis
We will review each table from the schema to check for compliance with 1NF, 2NF, and 3NF.

1. USER Table
Primary Key: user_id

Analysis:

1NF: All attributes (first_name, last_name, email, etc.) hold atomic values. The table has a primary key (user_id). It satisfies 1NF.

2NF: The primary key is a single column (user_id), so there can be no partial dependencies. It satisfies 2NF.

3NF: No non-key attribute is dependent on another non-key attribute. For example, first_name does not determine email. All attributes are solely dependent on user_id. It satisfies 3NF.

2. PROPERTY Table
Primary Key: property_id

Analysis:

1NF: All attributes hold single values. It has a primary key. It satisfies 1NF.

2NF: The primary key is a single column (property_id), so it automatically satisfies 2NF.

3NF: All non-key attributes like name, description, and location are dependent only on property_id. There are no transitive dependencies. It satisfies 3NF.

3. BOOKING Table
Primary Key: booking_id

Analysis:

1NF: All attributes are atomic. It has a primary key. It satisfies 1NF.

2NF: The primary key is a single column (booking_id), so it satisfies 2NF.

3NF: Attributes like start_date, end_date, and total_price are all directly dependent on the booking_id and not on other non-key attributes. It satisfies 3NF.

4. PAYMENT Table
Primary Key: payment_id

Analysis:

1NF: All attributes are atomic. It has a primary key. It satisfies 1NF.

2NF: The primary key is a single column (payment_id), satisfying 2NF.

3NF: The amount and payment_method are dependent only on payment_id. No transitive dependencies exist. It satisfies 3NF.

5. REVIEW Table
Primary Key: review_id

Analysis:

1NF: All attributes are atomic. It has a primary key. It satisfies 1NF.

2NF: The primary key is a single column (review_id), satisfying 2NF.

3NF: The rating and comment are dependent only on the review_id. No transitive dependencies exist. It satisfies 3NF.

6. MESSAGE Table
Primary Key: message_id

Analysis:

1NF: All attributes are atomic. It has a primary key. It satisfies 1NF.

2NF: The primary key is a single column (message_id), satisfying 2NF.

3NF: The message_body and sent_at timestamp are dependent only on message_id. No transitive dependencies exist. It satisfies 3NF.

Conclusion
The current database schema is already in Third Normal Form (3NF).

1NF is met: All tables have a primary key, and all columns contain atomic values.

2NF is met: All tables use a single-column primary key (UUID), so there are no partial dependencies to resolve.

3NF is met: There are no transitive dependencies found in any of the tables. Each non-key attribute is dependent solely on the primary key of its respective table.

Therefore, no adjustments are necessary to achieve 3NF compliance. The design effectively minimizes redundancy and ensures data integrity.
