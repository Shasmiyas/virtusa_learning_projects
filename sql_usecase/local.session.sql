-- create table departments
CREATE TABLE IF NOT EXISTS departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);
-- insert into departments
INSERT INTO departments (department_name)
VALUES ('CSE'),
('IT'),
('AIDS');
-- create table students
CREATE TABLE IF NOT EXISTS students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    department_id INT REFERENCES departments(department_id),
    phone_number VARCHAR(10) UNIQUE NOT NULL,
    address TEXT,
    joined_on DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active'
);
-- insert into students
INSERT INTO students (
        student_name,
        department_id,
        phone_number,
        address,
        joined_on
    )
VALUES ('Zoey', 1, '9080398767', 'ABC,XYZ', '2022-07-13'),
    ('Mina', 2, '6852546789', 'ABC,XYZ', '2022-08-14'),
    ('Rumi', 3, '8883768567', 'ABC,XYZ', '2023-09-18'),
    ('Ritu', 2, '7658947568', 'ABC,XYZ', '2025-07-13'),
    ('Arun', 1, '6578945325', 'ABC,XYZ', '2025-08-14'),
    ('Vivi', 3, '9856038905', 'ABC,XYZ', '2025-09-18');
--create categories table
CREATE TABLE IF NOT EXISTS categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE
);
--insert into categories
INSERT INTO categories (category_name)
VALUES ('fantasy'),
('romance'),
('action'),
('Sci-Fi');
-- create books table
CREATE TABLE IF NOT EXISTS books(
    book_id SERIAL PRIMARY KEY,
    book_title VARCHAR(255) NOT NULL UNIQUE,
    category_id INT REFERENCES categories(category_id),
    author VARCHAR(255) DEFAULT('anonymous author'),
    publication_date DATE CHECK(publication_date IS NULL OR publication_date < CURRENT_DATE),
    copies INT DEFAULT (0)
);
--insert into books
INSERT INTO books (
        book_title,
        category_id,
        author,
        publication_date,
        copies
    )
VALUES (
        'Harry Potter and the Philosopher’s Stone',
        1,
        'J.K.Rowling',
        '1865-01-01',
        1
    ),
    (
        'Jurassic Park',
        3,
        'Michael Crichton',
        '1990-01-01',
        2
    ),
    ('Project Hail Mary', 4, 'Andy Weir', '2021-05-4', 3),
    (
        'It Ends With Us',
        2,
        'Colleen Hoover',
        '2016-8-02',
        4
    );
--create issued_books
CREATE TABLE IF NOT EXISTS issued_books(
    issue_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(book_id) NOT NULL,
    student_id INT REFERENCES students(student_id) NOT NULL,
    issued_date DATE DEFAULT(CURRENT_DATE),
    return_date DATE DEFAULT(NULL),
    CHECK(return_date IS NULL OR issued_date <= return_date)
);
--insert into isseud_books students who returned books
INSERT INTO issued_books (book_id, student_id, issued_date, return_date)
VALUES (3, 1, '2022-09-14', '2022-09-29'),
    (4, 2, '2022-10-15', '2022-10-29'),
    (3, 4, '2026-02-14', '2026-03-10'),
    (4, 5, '2026-03-15', '2026-03-20');
--insert into isseud_books 
INSERT INTO issued_books (book_id, student_id, issued_date)
VALUES (4, 6, '2026-03-28'),
    (3, 3, '2026-03-25'),
    (2, 5, '2026-04-13');
--OVERDUE LOGIC
--query to find all students who haven't returned  a book
--where issued_date was more than 14 days and return_date is null
SELECT s.student_id,
    s.student_name,
    s.department_id,
    b.book_id,
    b.book_title,
    i.issue_id,
    i.issued_date,
    s.phone_number,
    s.address
FROM issued_books i
    INNER JOIN books b ON i.book_id = b.book_id
    INNER JOIN students s ON i.student_id = s.student_id
WHERE return_date IS NULL
    AND (issued_date <(CURRENT_DATE - INTERVAL '14 DAYS'))
    AND s.status='active';
--POPULARITY INDEX
--most borrowed category
WITH t AS (
    SELECT c.category_id,
        c.category_name,
        COUNT(*) AS total_count
    FROM categories c
        INNER JOIN books b ON b.category_id = c.category_id
        INNER JOIN issued_books i ON b.book_id = i.book_id
    GROUP BY c.category_id, c.category_name
) 
    SELECT t.category_id,t.category_name,t.total_count
    FROM t
    WHERE total_count=(
        SELECT MAX(t.total_count) FROM t
    );

--data cleanup
UPDATE students SET status='inactive'
WHERE student_id IN (
    SELECT DISTINCT student_id FROM issued_books
    GROUP BY student_id
    HAVING MAX(issued_date)<(CURRENT_DATE - INTERVAL '3 years') 
);