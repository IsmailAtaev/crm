/** SQL query active projects and users get  */
const sqlQueryGetActiveProjectsAndUsers = `
                                        SELECT 
                                            p.id AS project_id,
                                            p.name AS name,
                                            p.status AS status,
                                            p.priority AS priority,
                                            p."startDate" AS startDate,
                                            p."endDate" AS endDate,
                                            p.completion AS completion,
                                            p.archived AS archived,
                                            p."createdAt" AS createdAt,
                                            p."updatedAt" AS updatedAt,
                                            json_agg(
                                                json_build_object(
                                                    'id', u.id,
                                                    'name', u.name,
                                                    'surname', u.surname,
                                                    'mail', u.mail
                                                )
                                            ) AS users
                                        FROM 
                                            "projects" p
                                        JOIN 
                                            "tasks" t ON p.id = t."projectId"  
                                        JOIN 
                                            "users" u ON t."userId" = u.id
                                        WHERE 
                                            p.archived = false
                                        GROUP BY 
                                            p.id, p.name, p.status, p.priority, p."startDate", p."endDate", p.completion, p."createdAt", p."updatedAt"
                                        ORDER BY
                                            p."createdAt" DESC;`;



/** SQL query not active projects and users get  */
const sqlQueryGetNotActiveProjectsAndUsers = `
                                        SELECT 
                                            p.id AS project_id,
                                            p.name AS name,
                                            p.status AS status,
                                            p.priority AS priority,
                                            p."startDate" AS startDate,
                                            p."endDate" AS endDate,
                                            p.completion AS completion,
                                            p.archived AS archived,
                                            p."createdAt" AS createdAt,
                                            p."updatedAt" AS updatedAt,
                                            json_agg(
                                                json_build_object(
                                                    'id', u.id,
                                                    'name', u.name,
                                                    'surname', u.surname,
                                                    'mail', u.mail
                                                )
                                            ) AS users
                                        FROM 
                                            "projects" p
                                        JOIN 
                                            "tasks" t ON p.id = t."projectId"  
                                        JOIN 
                                            "users" u ON t."userId" = u.id
                                        WHERE 
                                            p.archived = true
                                        GROUP BY 
                                            p.id, p.name, p.status, p.priority, p."startDate", p."endDate", p.completion, p."createdAt", p."updatedAt"
                                        ORDER BY
                                            p."createdAt" ASC;`;


/** SQL query all projects and users get */
const sqlQueryGetProjectsAndUsers = `
                                        SELECT 
                                            p.id AS project_id,
                                            p.name AS name,
                                            p.status AS status,
                                            p.priority AS priority,
                                            p."startDate" AS startDate,
                                            p."endDate" AS endDate,
                                            p.completion AS completion,
                                            p.archived AS archived,
                                            p."createdAt" AS createdAt,
                                            p."updatedAt" AS updatedAt,
                                            json_agg(
                                                json_build_object(
                                                    'id', u.id,
                                                    'name', u.name,
                                                    'surname', u.surname,
                                                    'mail', u.mail
                                                )
                                            ) AS users
                                        FROM 
                                            "projects" p
                                        JOIN 
                                            "tasks" t ON p.id = t."projectId"  
                                        JOIN 
                                            "users" u ON t."userId" = u.id
                                        GROUP BY 
                                            p.id, p.name, p.status, p.priority, p."startDate", p."endDate", p.completion, p."createdAt", p."updatedAt"
                                        ORDER BY
                                            p."createdAt" ASC;`;


module.exports = { sqlQueryGetActiveProjectsAndUsers, sqlQueryGetNotActiveProjectsAndUsers, sqlQueryGetProjectsAndUsers };