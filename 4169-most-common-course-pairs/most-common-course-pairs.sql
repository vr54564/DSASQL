# Write your MySQL query statement below
# Write your MySQL query statement below
WITH find_top_user AS (
    SELECT user_id
    FROM course_completions 
    GROUP BY user_id
    HAVING COUNT(DISTINCT course_id) > 4 AND AVG(course_rating) >= 4
)
    SELECT A.course_name first_course, sub.course_name second_course, COUNT(1) transition_count
    FROM course_completions A 
    LEFT JOIN LATERAL (
        SELECT course_name
        FROM course_completions B 
        WHERE A.user_id = B.user_id AND A.completion_date < B.completion_date 
        LIMIT 1 
    ) sub ON  1 = 1
    WHERE A.user_id IN (select user_id FROM find_top_user) AND sub.course_name IS NOT NULL
    GROUP BY A.course_name, sub.course_name
    ORDER BY transition_count DESC, first_course, second_course