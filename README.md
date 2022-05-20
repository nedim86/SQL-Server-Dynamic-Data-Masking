# SQL-Server-Dynamic-Data-Masking

Dynamic data masking (DDM) limits sensitive data exposure by masking it to non-privileged users. It can be used to greatly simplify the design and coding of security in your application.

Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers to specify how much sensitive data to reveal with minimal impact on the application layer. DDM can be configured on designated database fields to hide sensitive data in the result sets of queries. With DDM the data in the database is not changed. DDM is easy to use with existing applications, since masking rules are applied in the query results. Many applications can mask sensitive data without modifying existing queries.

A central data masking policy acts directly on sensitive fields in the database.
Designate privileged users or roles that do have access to the sensitive data.
DDM features full masking and partial masking functions, and a random mask for numeric data.
Simple Transact-SQL commands define and manage masks.
The purpose of dynamic data masking is to limit exposure of sensitive data, preventing users who should not have access to the data from viewing it. Dynamic data masking does not aim to prevent database users from connecting directly to the database and running exhaustive queries that expose pieces of the sensitive data. Dynamic data masking is complementary to other SQL Server security features (auditing, encryption, row level security...) and it is highly recommended to use it in conjunction with them in order to better protect the sensitive data in the database.

Dynamic data masking is available in SQL Server 2016 (13.x) and Azure SQL Database, and is configured by using Transact-SQL commands. For more information about configuring dynamic data masking by using the Azure portal, see Get started with SQL Database Dynamic Data Masking (Azure portal).
