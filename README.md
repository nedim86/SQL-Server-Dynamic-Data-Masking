# Using Dynamic Data Masking in SQL Server 2016 to protect sensitive data

Dynamic data masking (DDM) limits sensitive data exposure by masking it to non-privileged users. It can be used to greatly simplify the design and coding of security in your application.

Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers to specify how much sensitive data to reveal with minimal impact on the application layer. DDM can be configured on designated database fields to hide sensitive data in the result sets of queries. With DDM the data in the database is not changed. DDM is easy to use with existing applications, since masking rules are applied in the query results. Many applications can mask sensitive data without modifying existing queries.

A central data masking policy acts directly on sensitive fields in the database.
Designate privileged users or roles that do have access to the sensitive data.
DDM features full masking and partial masking functions, and a random mask for numeric data.
Simple Transact-SQL commands define and manage masks.
The purpose of dynamic data masking is to limit exposure of sensitive data, preventing users who should not have access to the data from viewing it. Dynamic data masking does not aim to prevent database users from connecting directly to the database and running exhaustive queries that expose pieces of the sensitive data. Dynamic data masking is complementary to other SQL Server security features (auditing, encryption, row level security...) and it is highly recommended to use it in conjunction with them in order to better protect the sensitive data in the database.

Dynamic data masking is available in SQL Server 2016 (13.x) and Azure SQL Database, and is configured by using Transact-SQL commands. For more information about configuring dynamic data masking by using the Azure portal, see Get started with SQL Database Dynamic Data Masking (Azure portal).


# Masking functions

There are four main types of masking functions that can be configured in Dynamic Data Masking, which we will introduce briefly here and use in the demo later.

The first type is the Default function that masks the data according to the field data type; if the field data type is binary, varbinary or image, a single byte of binary value 0 will be used to mask that field. For the date and time data types, the 01.01.1900 00:00:00.0000000 value will be used to mask that date field. If the data type of the masked field is one of the numeric data types, a zero value will be used to mask that field. For the string data types, XXXX value will be used to mask that field. If the field length is less than 4 characters, less number of Xs will be used to mask its value.

The second masking method is the Email function that is used to mask the fields that store the email address. The Email function shows only the first character of the email address and mask the rest of the email, same as aXXX@XXXX.com.

The Random masking function is used to mask any numeric data type by replacing the original value with a random value within the range specified in that function.

The last masking type is the Custom function, that allows you to define your own mask for the specified field by exposing the first and last letters defined by the prefix and suffix and add a padding that will be shown in the middle in the form of prefix, [padding value], suffix, taking into consideration that part of the prefix or the suffix will not be exposed if the field’s original value is too short to be masked.

Like any feature in SQL Server, there are number of limitations for the Dynamic Data Masking feature, where you can’t define the DDM on an encrypted column, a column with FILESTREAM, COLUMN_SET or Sparse Column that is part of the Column_Set, Computed column or a key column in a FULLTEXT index. Also, if the column to be masked is part of an index or any type of dependencies, we should drop that dependency, configure the DDM on that column then create the dependency again. Also, Dynamic Data Masking will not prevent privileged users from altering the masked column or modifying the masked data, though.
