SELECT
COALESCE(DB_NAME(t.[dbid]),'Unknown') AS [DB Name],
ecp.objtype AS [Object Type],
t.[text] AS [Adhoc Batch or Object Call],
        SUBSTRING(t.[text], (qs.[statement_start_offset]/2) + 1,
        ((CASE qs.[statement_end_offset]
            WHEN -1 THEN DATALENGTH(t.[text]) ELSE qs.[statement_end_offset] END
                    - qs.[statement_start_offset])/2) + 1) AS [Executed Statement]
        , qs.[execution_count] AS [Counts]
        , qs.[total_worker_time] AS [Total Worker Time], (qs.[total_worker_time] /
qs.[execution_count]) AS [Avg Worker Time]
        , qs.[total_physical_reads] AS [Total Physical Reads],
(qs.[total_physical_reads] / qs.[execution_count]) AS [Avg Physical Reads]
        , qs.[total_logical_writes] AS [Total Logical Writes],
(qs.[total_logical_writes] / qs.[execution_count]) AS [Avg Logical Writes]
        , qs.[total_logical_reads] AS [Total Logical Reads],
(qs.[total_logical_reads] / qs.[execution_count]) AS [Avg Logical Reads]
        , qs.[total_clr_time] AS [Total CLR Time], (qs.[total_clr_time] /
qs.[execution_count]) AS [Avg CLR Time]
        , qs.[total_elapsed_time] AS [Total Elapsed Time], (qs.[total_elapsed_time]
/ qs.[execution_count]) AS [Avg Elapsed Time]
        , qs.[last_execution_time] AS [Last Exec Time], qs.[creation_time] AS [Creation Time]
FROM sys.dm_exec_query_stats AS qs
    JOIN sys.dm_exec_cached_plans ecp ON qs.plan_handle = ecp.plan_handle
        CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS t
--    ORDER BY [Total Worker Time] DESC
--    ORDER BY [Total Physical Reads] DESC
--    ORDER BY [Total Logical Writes] DESC
--    ORDER BY [Total Logical Reads] DESC
--    ORDER BY [Total CLR Time] DESC
--    ORDER BY [Total Elapsed Time] DESC
        ORDER BY [Counts] DESC