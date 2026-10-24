START TRANSACTION;

UPDATE food_recommendations AS f
JOIN deficiency_master AS d ON d.deficiency_id = f.deficiency_id
SET f.benefits = CASE f.food_name
        WHEN 'Almonds' THEN 'Provide biotin along with unsaturated fats, protein, and vitamin E as part of a varied diet.'
        WHEN 'Eggs' THEN 'Cooked egg yolks provide biotin and protein; cooking also makes raw egg-white avidin less of a concern.'
        WHEN 'Salmon' THEN 'Provides biotin along with protein and omega-3 fats.'
        WHEN 'Spinach' THEN 'Provides a small amount of biotin as part of a varied diet, as well as folate and other nutrients.'
        WHEN 'Sweet Potatoes' THEN 'Provide biotin along with fiber and provitamin A carotenoids.'
        ELSE f.benefits
    END,
    f.avoid_food = CASE f.food_name
        WHEN 'Almonds' THEN 'Avoid if you have a tree-nut allergy; no specific restriction is needed for most people.'
        WHEN 'Eggs' THEN 'Avoid raw egg whites; cook eggs thoroughly. People with an egg allergy should avoid eggs.'
        WHEN 'Salmon' THEN 'Avoid if you have a fish allergy; follow local food-safety advice for preparation.'
        WHEN 'Spinach' THEN 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.'
        WHEN 'Sweet Potatoes' THEN 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.'
        ELSE f.avoid_food
    END
WHERE d.deficiency_name = 'Biotin Deficiency'
  AND f.food_name IN ('Almonds', 'Eggs', 'Salmon', 'Spinach', 'Sweet Potatoes');

INSERT INTO food_recommendations (deficiency_id, food_name, benefits, avoid_food)
SELECT d.deficiency_id, recommendations.food_name, recommendations.benefits, recommendations.avoid_food
FROM deficiency_master AS d
JOIN (
    SELECT 'Calcium Deficiency' AS deficiency_name, 'Plain yogurt' AS food_name, 'Provides calcium and protein; choose a variety that fits your needs.' AS benefits, 'If you have a milk allergy, choose a suitable fortified alternative; lactose-free dairy may still provide calcium.' AS avoid_food
    UNION ALL SELECT 'Calcium Deficiency', 'Milk or calcium-fortified soy beverage', 'Provides calcium; fortified soy beverages can be a useful option when dairy is not used. Check the label for calcium content.', 'Shake fortified beverages before pouring and check labels, since calcium content varies; follow clinician advice if you have kidney disease.'
    UNION ALL SELECT 'Calcium Deficiency', 'Calcium-set tofu', 'Can provide calcium and plant protein; calcium content depends on the coagulant and product label.', 'Check the label because tofu made with other coagulants may contain much less calcium.'
    UNION ALL SELECT 'Calcium Deficiency', 'Sardines with edible bones', 'Provide calcium from edible bones as well as protein and vitamin D.', 'Choose lower-sodium options when needed; avoid if you have a fish allergy.'

    UNION ALL SELECT 'Copper Deficiency', 'Cooked oysters', 'A concentrated food source of copper, as well as protein and other minerals.', 'Avoid raw oysters because of foodborne illness risk; if you have Wilson disease or a copper restriction, follow specialist advice.'
    UNION ALL SELECT 'Copper Deficiency', 'Cashews', 'Provide copper along with unsaturated fats and protein.', 'Avoid if you have a tree-nut allergy; people with Wilson disease should follow specialist advice about copper-rich foods.'
    UNION ALL SELECT 'Copper Deficiency', 'Sunflower seeds', 'Provide copper, unsaturated fats, and other minerals.', 'Avoid if you have a seed allergy; people with Wilson disease should follow specialist advice about copper-rich foods.'
    UNION ALL SELECT 'Copper Deficiency', 'Chickpeas', 'Provide copper and plant protein in a versatile legume.', 'No specific restriction is needed for most people; increase fiber-rich foods gradually if they cause digestive discomfort.'

    UNION ALL SELECT 'Folate Deficiency', 'Lentils', 'Provide folate, fiber, and plant protein.', 'No specific restriction is needed for most people; follow medical advice if you take medicines that affect folate.'
    UNION ALL SELECT 'Folate Deficiency', 'Cooked spinach', 'Provides folate as part of a varied diet.', 'No specific restriction is needed for most people unless you have a clinician-directed dietary restriction.'
    UNION ALL SELECT 'Folate Deficiency', 'Asparagus', 'Provides folate and fiber.', 'No specific restriction is needed for most people unless you have an allergy.'
    UNION ALL SELECT 'Folate Deficiency', 'Avocado', 'Provides folate and unsaturated fats.', 'No specific restriction is needed for most people unless you have an allergy.'

    UNION ALL SELECT 'Iodine Deficiency', 'Iodized salt', 'A reliable source of iodine when used in place of non-iodized salt; use modest amounts.', 'Do not increase salt intake to obtain iodine. Ask a clinician about iodine intake if you have thyroid disease or are pregnant.'
    UNION ALL SELECT 'Iodine Deficiency', 'Cod', 'Provides iodine and protein; iodine content varies by species and source.', 'Avoid if you have a fish allergy; follow clinician guidance for thyroid conditions.'
    UNION ALL SELECT 'Iodine Deficiency', 'Milk or yogurt', 'Dairy foods can contribute iodine as well as protein or calcium; levels vary by product and region.', 'Choose a suitable alternative if you have a milk allergy; plant beverages are not necessarily iodine-fortified.'
    UNION ALL SELECT 'Iodine Deficiency', 'Eggs', 'Provide iodine and protein; content varies with production and serving size.', 'Avoid if you have an egg allergy; do not use seaweed or iodine supplements as a substitute for clinical advice.'

    UNION ALL SELECT 'Magnesium Deficiency', 'Pumpkin seeds', 'Provide magnesium, plant protein, and unsaturated fats.', 'Avoid if you have a seed allergy; people with significant kidney disease should ask a clinician before using magnesium supplements.'
    UNION ALL SELECT 'Magnesium Deficiency', 'Black beans', 'Provide magnesium along with fiber and plant protein.', 'No specific restriction is needed for most people; increase fiber gradually if needed.'
    UNION ALL SELECT 'Magnesium Deficiency', 'Cooked spinach', 'Provides magnesium and folate as part of a varied diet.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.'
    UNION ALL SELECT 'Magnesium Deficiency', 'Oats', 'Provide magnesium and whole-grain fiber.', 'Choose certified gluten-free oats if required for celiac disease or gluten sensitivity.'

    UNION ALL SELECT 'Potassium Deficiency', 'Baked potato with skin', 'Provides potassium and fiber.', 'If you have kidney disease or take medicines that raise potassium, ask your clinician before increasing potassium-rich foods.'
    UNION ALL SELECT 'Potassium Deficiency', 'White beans', 'Provide potassium, plant protein, and fiber.', 'If you have kidney disease or take medicines that raise potassium, seek individualized advice before increasing intake.'
    UNION ALL SELECT 'Potassium Deficiency', 'Plain yogurt', 'Provides potassium and protein; amounts vary by product.', 'Choose a suitable alternative for milk allergy; ask a clinician before increasing potassium if you have kidney disease or relevant medicines.'
    UNION ALL SELECT 'Potassium Deficiency', 'Banana', 'Provides potassium and carbohydrate in a convenient whole fruit.', 'If you have kidney disease or take medicines that raise potassium, ask your clinician before increasing intake.'

    UNION ALL SELECT 'Selenium Deficiency', 'Cooked fish', 'Fish such as tuna can provide selenium and protein; levels vary by species.', 'Follow local advice about fish choices and mercury, especially during pregnancy; avoid if you have a fish allergy.'
    UNION ALL SELECT 'Selenium Deficiency', 'Eggs', 'Provide selenium and protein as part of a varied diet.', 'Avoid if you have an egg allergy; no special restriction is needed for most people.'
    UNION ALL SELECT 'Selenium Deficiency', 'Chicken', 'Provides selenium and protein.', 'Cook thoroughly and follow food-safety guidance; no specific restriction is needed for most people.'
    UNION ALL SELECT 'Selenium Deficiency', 'Whole-grain bread', 'Can contribute selenium, though amounts vary with growing conditions and ingredients.', 'Choose an option that fits any allergy, celiac, or other clinician-directed dietary needs.'

    UNION ALL SELECT 'Vitamin A Deficiency', 'Sweet potato', 'Provides beta-carotene, which the body can convert to vitamin A, along with fiber.', 'No specific restriction is needed for most people; food beta-carotene is not the same as high-dose retinol supplements.'
    UNION ALL SELECT 'Vitamin A Deficiency', 'Carrots', 'Provide beta-carotene, a provitamin A carotenoid.', 'No specific restriction is needed for most people; avoid relying on high-dose vitamin A supplements without clinical advice.'
    UNION ALL SELECT 'Vitamin A Deficiency', 'Cooked spinach', 'Provides provitamin A carotenoids as part of a varied diet.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.'
    UNION ALL SELECT 'Vitamin A Deficiency', 'Eggs', 'Provide preformed vitamin A along with protein and other nutrients.', 'Avoid high-dose retinol supplements and frequent liver intake during pregnancy unless specifically directed by a clinician.'

    UNION ALL SELECT 'Vitamin B1 Deficiency', 'Pork', 'Provides thiamin and protein.', 'Cook thoroughly and choose lean, minimally processed options when possible.'
    UNION ALL SELECT 'Vitamin B1 Deficiency', 'Black beans', 'Provide thiamin, fiber, and plant protein.', 'No specific restriction is needed for most people; seek medical care for suspected deficiency rather than relying on food alone.'
    UNION ALL SELECT 'Vitamin B1 Deficiency', 'Whole-grain bread', 'Whole grains can provide thiamin and fiber.', 'Check labels if you need a specific grain-free or gluten-free diet.'
    UNION ALL SELECT 'Vitamin B1 Deficiency', 'Thiamin-fortified breakfast cereal', 'Fortified cereals can contribute thiamin; check the nutrition label for amounts.', 'Choose a lower-sugar option where practical; food changes do not replace urgent assessment for severe symptoms.'

    UNION ALL SELECT 'Vitamin B12 Deficiency', 'Salmon', 'Provides vitamin B12 and protein.', 'Avoid if you have a fish allergy; follow local fish-safety advice.'
    UNION ALL SELECT 'Vitamin B12 Deficiency', 'Eggs', 'Provide vitamin B12 and protein.', 'Avoid if you have an egg allergy; eggs alone may not correct a confirmed deficiency.'
    UNION ALL SELECT 'Vitamin B12 Deficiency', 'Milk or yogurt', 'Dairy foods provide vitamin B12 and can contribute protein and calcium.', 'Choose a suitable alternative if you have a milk allergy; most plant beverages need B12 fortification to provide it.'
    UNION ALL SELECT 'Vitamin B12 Deficiency', 'Vitamin B12-fortified breakfast cereal', 'Fortified cereal can provide B12; check the label and serving size.', 'Unfortified plant foods are not reliable sources of B12; people following vegan diets need a reliable fortified food or clinician-directed supplement.'

    UNION ALL SELECT 'Vitamin B2 Deficiency', 'Milk or yogurt', 'Dairy foods provide riboflavin (vitamin B2) and other nutrients.', 'Choose a suitable alternative for milk allergy and check whether plant beverages are riboflavin-fortified.'
    UNION ALL SELECT 'Vitamin B2 Deficiency', 'Eggs', 'Provide riboflavin and protein.', 'Avoid if you have an egg allergy; no other general restriction is needed.'
    UNION ALL SELECT 'Vitamin B2 Deficiency', 'Mushrooms', 'Some mushroom varieties provide riboflavin and fiber.', 'Cook and store safely; avoid if you have a mushroom allergy or intolerance.'
    UNION ALL SELECT 'Vitamin B2 Deficiency', 'Riboflavin-fortified cereal', 'Fortified cereal can contribute riboflavin; check the nutrition label.', 'Choose an option that fits your overall dietary needs; a confirmed deficiency may need clinical treatment.'

    UNION ALL SELECT 'Vitamin B3 Deficiency', 'Chicken', 'Provides niacin (vitamin B3) and protein.', 'Cook thoroughly and choose lean, minimally processed options when possible.'
    UNION ALL SELECT 'Vitamin B3 Deficiency', 'Tuna', 'Provides niacin and protein.', 'Follow local advice on tuna frequency and mercury, especially during pregnancy; avoid if you have a fish allergy.'
    UNION ALL SELECT 'Vitamin B3 Deficiency', 'Peanuts', 'Provide niacin along with protein and unsaturated fats.', 'Avoid if you have a peanut allergy; high-dose niacin supplements can cause harm and require medical supervision.'
    UNION ALL SELECT 'Vitamin B3 Deficiency', 'Brown rice', 'Provides niacin and whole-grain fiber.', 'Choose a suitable grain alternative if required; food sources do not replace care for a confirmed deficiency.'

    UNION ALL SELECT 'Vitamin B6 Deficiency', 'Chickpeas', 'Provide vitamin B6, fiber, and plant protein.', 'No specific restriction is needed for most people; avoid high-dose B6 supplements unless prescribed.'
    UNION ALL SELECT 'Vitamin B6 Deficiency', 'Salmon', 'Provides vitamin B6, protein, and omega-3 fats.', 'Avoid if you have a fish allergy; follow local fish-safety advice.'
    UNION ALL SELECT 'Vitamin B6 Deficiency', 'Potatoes', 'Provide vitamin B6 and carbohydrate as part of a varied meal.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.'
    UNION ALL SELECT 'Vitamin B6 Deficiency', 'Banana', 'Provides vitamin B6 and carbohydrate as a whole fruit.', 'No specific restriction is needed for most people; avoid prolonged high-dose B6 supplements unless prescribed.'

    UNION ALL SELECT 'Vitamin C Deficiency', 'Red bell pepper', 'Provides vitamin C; eating it raw or lightly cooked can help preserve vitamin C.', 'Avoid if you have an allergy or intolerance; no high-dose supplement is needed unless clinically advised.'
    UNION ALL SELECT 'Vitamin C Deficiency', 'Orange', 'Provides vitamin C and fluid as a whole fruit.', 'If citrus worsens reflux or irritation, choose another vitamin C-rich fruit or vegetable.'
    UNION ALL SELECT 'Vitamin C Deficiency', 'Kiwi', 'Provides vitamin C and fiber.', 'Avoid if you have a kiwi allergy; choose another fruit if it causes oral irritation.'
    UNION ALL SELECT 'Vitamin C Deficiency', 'Broccoli', 'Provides vitamin C and fiber; brief cooking can reduce losses compared with prolonged boiling.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed restriction.'

    UNION ALL SELECT 'Vitamin D Deficiency', 'Salmon', 'Provides vitamin D and protein; amounts vary by species and serving.', 'Avoid if you have a fish allergy; food alone may not correct a confirmed deficiency.'
    UNION ALL SELECT 'Vitamin D Deficiency', 'Trout', 'Provides vitamin D and protein; amounts vary by source and serving.', 'Avoid if you have a fish allergy; follow local fish-safety advice.'
    UNION ALL SELECT 'Vitamin D Deficiency', 'Vitamin D-fortified milk', 'Fortified milk can contribute vitamin D; check the label for the amount per serving.', 'Choose a suitable alternative for milk allergy and check that plant beverages are fortified.'
    UNION ALL SELECT 'Vitamin D Deficiency', 'Vitamin D-fortified soy beverage', 'A fortified plant beverage can contribute vitamin D; check the label and shake before pouring if directed.', 'Fortification varies by product; do not take high-dose vitamin D supplements without clinical guidance.'

    UNION ALL SELECT 'Vitamin E Deficiency', 'Sunflower seeds', 'Provide vitamin E and unsaturated fats.', 'Avoid if you have a seed allergy; high-dose vitamin E supplements can interact with medicines and should be clinician-directed.'
    UNION ALL SELECT 'Vitamin E Deficiency', 'Almonds', 'Provide vitamin E, fiber, and unsaturated fats.', 'Avoid if you have a tree-nut allergy; high-dose vitamin E supplements can increase bleeding risk.'
    UNION ALL SELECT 'Vitamin E Deficiency', 'Sunflower oil', 'Provides vitamin E; use as one option among varied unsaturated oils.', 'Use appropriate portions and avoid repeatedly heating oil to smoking; avoid if you have a relevant allergy.'
    UNION ALL SELECT 'Vitamin E Deficiency', 'Avocado', 'Provides vitamin E and unsaturated fats.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.'

    UNION ALL SELECT 'Vitamin K Deficiency', 'Kale', 'Provides vitamin K1 and other nutrients.', 'If you take warfarin, keep vitamin K intake consistent and coordinate changes with your clinician rather than avoiding these foods.'
    UNION ALL SELECT 'Vitamin K Deficiency', 'Spinach', 'Provides vitamin K1 as part of a varied diet.', 'If you take warfarin, maintain a consistent intake and follow your anticoagulation clinician''s advice.'
    UNION ALL SELECT 'Vitamin K Deficiency', 'Broccoli', 'Provides vitamin K1 and other nutrients.', 'If you take warfarin, do not make sudden large changes in intake without discussing them with your clinician.'
    UNION ALL SELECT 'Vitamin K Deficiency', 'Canola or soybean oil', 'These oils can contribute vitamin K1; amounts vary by product and serving.', 'If you take warfarin, focus on consistent intake and seek clinician guidance before major dietary changes.'

    UNION ALL SELECT 'Zinc Deficiency', 'Cooked oysters', 'Provide zinc; amounts can be high and vary by species and serving.', 'Avoid raw oysters because of foodborne illness risk; avoid if you have a shellfish allergy.'
    UNION ALL SELECT 'Zinc Deficiency', 'Beef', 'Provides zinc and protein.', 'Choose lean, unprocessed options and moderate portions; avoid if you have an allergy or dietary restriction.'
    UNION ALL SELECT 'Zinc Deficiency', 'Pumpkin seeds', 'Provide zinc, plant protein, and unsaturated fats.', 'Avoid if you have a seed allergy; high-dose zinc supplements can cause copper deficiency.'
    UNION ALL SELECT 'Zinc Deficiency', 'Chickpeas', 'Provide zinc, fiber, and plant protein; soaking and thorough cooking can improve meal digestibility.', 'Plant phytates can reduce zinc absorption, so include a varied diet; do not use high-dose zinc supplements without clinical advice.'
) AS recommendations ON recommendations.deficiency_name = d.deficiency_name
LEFT JOIN food_recommendations AS existing
    ON existing.deficiency_id = d.deficiency_id
    AND LOWER(existing.food_name) = LOWER(recommendations.food_name)
WHERE existing.id IS NULL;

COMMIT;
