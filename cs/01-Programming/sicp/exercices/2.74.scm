; Insatiable Enterprises, Inc., is a highly de-
; centralized conglomerate company consisting of a large num-
; ber of independent divisions located all over the world. The
; company’s computer facilities have just been interconnected
; by means of a clever network-interfacing scheme that makes
; the entire network appear to any user to be a single com-
; puter. Insatiable’s president, in her first attempt to exploit
; the ability of the network to extract administrative infor-
; mation from division files, is dismayed to discover that, al-
; though all the division files have been implemented as data
; structures in Scheme, the particular data structure used varies
; from division to division. A meeting of division managers
; is hastily called to search for a strategy to integrate the files
; that will satisfy headquarters’ needs while preserving the
; existing autonomy of the divisions.

; Show how such a strategy can be implemented with data-
; directed programming. As an example, suppose that each
; division’s personnel records consist of a single file, which
; contains a set of records keyed on employees’ names. The
; structure of the set varies from division to division. Fur-
; thermore, each employee’s record is itself a set (structured
; differently from division to division) that contains informa-
; tion keyed under identifiers such as address and salary.

; In particular:

; a. Implement for headquarters a get-record procedure
; that retrieves a specified employee’s record from a
; specified personnel file. The procedure should be ap-
; plicable to any division’s file. Explain how the individ-
; ual divisions’ files should be structured. In particular,
; what type information must be supplied?

; b. Implement for headquarters a get-salary procedure
; that returns the salary information from a given em-
; ployee’s record from any division’s personnel file. How
; should the record be structured in order to make this
; operation work?

; c. Implement for headquarters a find-employee-record
; procedure. This should search all the divisions’ files
; for the record of a given employee and return the record.
; Assume that this procedure takes as arguments an
; employee’s name and a list of all the divisions’ files.

; d.When Insatiable takes over a new company, what changes
; must be made in order to incorporate the new person-
; nel information into the central system?

; a.
; Assuming we have an operation table with 
; get-record implementation different for each division.
; We assume too that a procedure division take a file
; as argument and return a division tag.
; It means that the division needs to be somehow found from the files (from the filename for example)

(define (get-record employee file)
  (let ((proc (get 'get-record (division file))))
  (proc employee)))

; The division is the type which should be supplied. 
; How to get the record depends on the division, since every division has a different 

; b.

(define (get-salary record file)
  (let ((proc (get 'get-salary (division file))))
  (proc record)))

; The good record for the division needs to be provided (using get-record), otherwise it won't work.
; Another more secure solution would be first get the record, then the salary.

(define (get-salary employee file)
  (let ((record ((get 'get-record (division file)) employee))
        (proc (get 'get-salary (division file))))
  (proc record)))

; c.
; We assume that 
(define (find-employee-record employee files)
    (define (find record files)
    (if (not (empty? record))
      record
      (find (get 'get-record (division (car files)) (cdr files)))))
  (find '() files))

; d
; Insatiable will only need to change the operation table.
; It needs to add new procedures in the table for the new division.
; More precisely, it needs to implement get-salary and get-record for the new division
; It might as well rename every files to get the division from the file.
; Easy with a bash scripts :D

**GOOD?**

; Could have been better by adding the tag to each record / salary returned, to know of what type they are...


