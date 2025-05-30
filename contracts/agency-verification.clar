;; Agency Verification Contract
;; Validates quantum prediction systems and authorized agencies

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_VERIFIED (err u102))
(define-constant ERR_INVALID_AGENCY (err u103))

;; Data structures
(define-map verified-agencies principal bool)
(define-map agency-details
  principal
  {
    name: (string-ascii 100),
    verification-date: uint,
    quantum-capability-score: uint,
    active: bool
  }
)

;; Agency verification status
(define-read-only (is-agency-verified (agency principal))
  (default-to false (map-get? verified-agencies agency))
)

;; Get agency details
(define-read-only (get-agency-details (agency principal))
  (map-get? agency-details agency)
)

;; Verify an agency (only contract owner)
(define-public (verify-agency
  (agency principal)
  (name (string-ascii 100))
  (quantum-score uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (not (is-agency-verified agency)) ERR_ALREADY_VERIFIED)
    (asserts! (> quantum-score u0) ERR_INVALID_AGENCY)

    (map-set verified-agencies agency true)
    (map-set agency-details agency {
      name: name,
      verification-date: block-height,
      quantum-capability-score: quantum-score,
      active: true
    })
    (ok true)
  )
)

;; Revoke agency verification
(define-public (revoke-agency (agency principal))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-agency-verified agency) ERR_NOT_VERIFIED)

    (map-set verified-agencies agency false)
    (map-set agency-details agency
      (merge
        (unwrap-panic (get-agency-details agency))
        { active: false }
      )
    )
    (ok true)
  )
)

;; Update agency quantum score
(define-public (update-quantum-score (agency principal) (new-score uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (is-agency-verified agency) ERR_NOT_VERIFIED)

    (map-set agency-details agency
      (merge
        (unwrap-panic (get-agency-details agency))
        { quantum-capability-score: new-score }
      )
    )
    (ok true)
  )
)
