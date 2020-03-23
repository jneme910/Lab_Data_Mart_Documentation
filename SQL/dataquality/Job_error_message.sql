SELECT MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) as date_time
    ,j.name as job_name,js.step_id as job_step,jh.message as error_message
    FROM msdb.dbo.sysjobs AS j
    INNER JOIN msdb.dbo.sysjobsteps AS js ON js.job_id = j.job_id
    INNER JOIN msdb.dbo.sysjobhistory AS jh ON jh.job_id = j.job_id AND jh.step_id = js.step_id
    WHERE jh.run_status = 0 AND MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) >= GETDATE()-1
    ORDER BY MSDB.dbo.agent_datetime(jh.run_date,jh.run_time) DESC

	