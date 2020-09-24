#README  
##テーブルスキーマ  

Userモデル  

  *id | integer  
  *name | string  
  *password | integer  
    
Taskモデル  

　 *id | integer  
   *user_id | integer  
   *task_name | string  
   *details | text  
   *deadline | date  
   *status | string  
   *priority | string  
   *label | string  
