from cnc.app_code.db_connection import db_connection


class AgentsDB(db_connection):
    def __init__(self):
        super().__init__()

    @property
    def get_all_available_agents(self):
        sql = """SELECT * FROM Agents where status != 'DIED'"""
        return self.get_data(sql);

    def get_agent_by_id(self, agent_id):
        sql = "SELECT * from Agents where id={0}".format(agent_id)
        return self.get_data(sql)[0]

    # CNC -> AGENT -> DB
    def insert_agent(self, host_name, host_ip, host_port):
        sql = """INSERT INTO Agents
                  (host_name, ip, port,status) 
                   OUTPUT Inserted.id as row_id 
                   VALUES(N'{0}',N'{1}',N'{2}',N'{3}')""".format(host_name, host_ip, host_port, "WAITING")
        agent_id = self.get_data(sql)[0][0]
        return agent_id

    def delete_agent(self, agent_id):
        sql = """DELETE FROM Agents
                 WHERE id={0}""".format(agent_id)
        self.execute(sql)

    def insert_malware_to_agent(self, agent_id, malware_id):
        sql = """INSERT INTO Agent_malwares
               (agent_id, malware_id) 
                OUTPUT Inserted.id as row_id 
                VALUES(N'{0}', N'{1}')""".format(agent_id, malware_id)
        agent_malware_id = self.get_data(sql)[0][0]
        return agent_malware_id

    def insert_agent_log(self, agent_id, malware_id, status, log, csv_row_id):
        sql = """INSERT INTO Agents_logs
               (agent_id, malware_id, status, action_log, csv_row_id) 
                OUTPUT Inserted.id as row_id 
                VALUES(N'{0}',N'{1}',N'{2}',N'{3}', N'{4}')""".format(agent_id, malware_id, status, log, csv_row_id)
        log_id = self.get_data(sql)[0][0]
        return log_id

    def update_agent_status_port(self, agent_id, port,status):
        sql = """UPDATE Agents
                SET status = N'{0}' , port=N'{1}'
                WHERE Id = N'{2}'""".format(status, port,agent_id)
        self.execute(sql)
    def update_agent_status(self, agent_id,status):
        sql = """UPDATE Agents
                SET status = N'{0}' 
                WHERE Id = N'{1}'""".format(status,agent_id)
        self.execute(sql)
    def get_agent_id(self, host_name, host_ip):
        sql = """SELECT Id FROM Agents
                WHERE 
                host_name = N'{0}'
                AND ip = N'{1}'""".format(host_name, host_ip)
        agent_id = self.get_data(sql)
        return agent_id


class MalwaresDB(db_connection):
    def __init__(self):
        super().__init__()

    def INSERT(self, name, description):
        sql = """INSERT INTO Malwares
               (name,description,publisher) 
                OUTPUT Inserted.id as row_id 
                VALUES(N'{0}',N'{1}',N'{2}')""".format(name, description, 'ReWare USER')
        id = self.get_data(sql)[0][0]
        return id

    def GET_MALWARE(self, malware_id):
        sql = "SELECT * from Malwares where id={0}".format(malware_id)
        return self.get_data(sql)

    def UPDATE_STATUS(self, malware_id, status):
        sql = """UPDATE Malwares SET status=N'{1}' where id={0}""".format(malware_id, status)
        self.execute(sql)

    def DELETE(self, malware_id):
        sql = "DELETE FROM Malwares where id={0}".format(malware_id)
        self.execute(sql)
