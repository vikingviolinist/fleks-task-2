SELECT
    subs.id AS subscriptionId,
    tmp.planId,
    tmp.planName,
    tmp.periodCount,
    tmp.periodPrice,
    tmp.periodCount * tmp.periodPrice AS total
FROM
    public."Subscriptions" AS subs
    LEFT JOIN (
        SELECT
            subplans."subscriptionId",
            p.id AS planId,
            p.name AS planName,
            (
                SELECT
                    COUNT(*)
                FROM
                    public."SubscriptionPeriods" AS subperiods
                WHERE
                    subplans."subscriptionId" = subperiods."subscriptionId"
            ) AS periodCount,
            p.price AS periodPrice
        FROM
            public."SubscriptionPlans" subplans
            JOIN public."Plans" p ON subplans."planId" = p.id
    ) AS tmp ON tmp."subscriptionId" = subs.id
ORDER BY
    total DESC NULLS LAST,
    tmp.periodPrice DESC NULLS LAST;