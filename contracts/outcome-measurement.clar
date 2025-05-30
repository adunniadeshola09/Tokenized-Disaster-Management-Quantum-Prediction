;; Outcome Measurement Contract
;; Evaluates quantum prediction effectiveness

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_OUTCOME_NOT_FOUND (err u501))
(define-constant ERR_INVALID_OUTCOME (err u502))
(define-constant ERR_ALREADY_MEASURED (err u503))

;; Data structures
(define-map prediction-outcomes
  uint
  {
    prediction-id: uint,
    actual-occurred: bool,
    actual-severity: (optional uint),
    accuracy-score: uint,
    response-effectiveness: uint,
    measured-by: principal,
    measurement-time: uint,
    notes: (string-ascii 200)
  }
)

(define-map agency-performance
  principal
  {
    total-predictions: uint,
    accurate-predictions: uint,
    accuracy-rate: uint,
    last-updated: uint
  }
)

;; Get prediction outcome
(define-read-only (get-prediction-outcome (prediction-id uint))
  (map-get? prediction-outcomes prediction-id)
)

;; Get agency performance
(define-read-only (get-agency-performance (agency principal))
  (map-get? agency-performance agency)
)

;; Record prediction outcome
(define-public (record-outcome
  (prediction-id uint)
  (actual-occurred bool)
  (actual-severity (optional uint))
  (response-effectiveness uint)
  (notes (string-ascii 200)))
  (begin
    (asserts! (is-none (get-prediction-outcome prediction-id)) ERR_ALREADY_MEASURED)
    (asserts! (and (>= response-effectiveness u0) (<= response-effectiveness u100)) ERR_INVALID_OUTCOME)

    (let
      ((accuracy-score (if actual-occurred u100 u0)))

      (map-set prediction-outcomes prediction-id {
        prediction-id: prediction-id,
        actual-occurred: actual-occurred,
        actual-severity: actual-severity,
        accuracy-score: accuracy-score,
        response-effectiveness: response-effectiveness,
        measured-by: tx-sender,
        measurement-time: block-height,
        notes: notes
      })

      (ok true)
    )
  )
)

;; Update agency performance metrics
(define-public (update-agency-performance (agency principal) (prediction-id uint))
  (let
    ((outcome (unwrap! (get-prediction-outcome prediction-id) ERR_OUTCOME_NOT_FOUND))
     (current-perf (default-to
       { total-predictions: u0, accurate-predictions: u0, accuracy-rate: u0, last-updated: u0 }
       (get-agency-performance agency)))
     (new-total (+ (get total-predictions current-perf) u1))
     (new-accurate (if (get actual-occurred outcome)
                     (+ (get accurate-predictions current-perf) u1)
                     (get accurate-predictions current-perf)))
     (new-rate (if (> new-total u0) (/ (* new-accurate u100) new-total) u0)))

    (map-set agency-performance agency {
      total-predictions: new-total,
      accurate-predictions: new-accurate,
      accuracy-rate: new-rate,
      last-updated: block-height
    })

    (ok true)
  )
)

;; Calculate prediction accuracy
(define-read-only (calculate-prediction-accuracy (prediction-id uint))
  (let
    ((outcome (unwrap! (get-prediction-outcome prediction-id) ERR_OUTCOME_NOT_FOUND)))
    (ok (get accuracy-score outcome))
  )
)

;; Get system-wide accuracy metrics
(define-read-only (get-system-accuracy)
  ;; This would require iterating through all agencies
  ;; For simplicity, returning a placeholder
  (ok u85)
)

;; Calculate response effectiveness score
(define-read-only (calculate-response-effectiveness (prediction-id uint))
  (let
    ((outcome (unwrap! (get-prediction-outcome prediction-id) ERR_OUTCOME_NOT_FOUND)))
    (ok (get response-effectiveness outcome))
  )
)
