USE shopdb;
## Json 데이터 형식으로 조회
SELECT 
    mid,
    mname,
    maddress,
    JSON_OBJECT('mid',
            mid,
            'mname',
            mname,
            'maddress',
            maddress) AS json_data
FROM
    t_member;

-- { k : v } form is JSON data form 
