CREATE TABLE `policy_recommendation_profile` (
  `policy_recommendation_profile_id` bigint NOT NULL AUTO_INCREMENT COMMENT '정책금융 추천 프로필 식별자',
  `user_id` bigint NOT NULL COMMENT '회원 식별자',
  `residence_sido` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거주 시도',
  `residence_sigungu` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거주 시군구',
  `residence_months` int DEFAULT NULL COMMENT '현재 지역 거주기간(개월)',
  `employment_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고용 형태',
  `employment_months` int DEFAULT NULL COMMENT '재직기간(개월)',
  `has_income` tinyint(1) DEFAULT NULL COMMENT '소득 존재 여부',
  `income_verifiable` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소득증빙 가능 여부',
  `household_size` int DEFAULT NULL COMMENT '가구원 수',
  `marital_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '혼인 상태',
  `has_children` tinyint(1) DEFAULT NULL COMMENT '자녀 여부',
  `children_count` int DEFAULT NULL COMMENT '자녀 수',
  `basic_livelihood_recipient` tinyint(1) NOT NULL DEFAULT '0' COMMENT '기초생활수급자 여부',
  `near_poverty` tinyint(1) NOT NULL DEFAULT '0' COMMENT '차상위계층 여부',
  `single_parent_household` tinyint(1) NOT NULL DEFAULT '0' COMMENT '한부모가구 여부',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '장애 여부',
  `self_reliance_youth` tinyint(1) NOT NULL DEFAULT '0' COMMENT '자립준비청년 여부',
  `multicultural_household` tinyint(1) NOT NULL DEFAULT '0' COMMENT '다문화가구 여부',
  `debt_default_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '채무불이행 여부',
  `overdue_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '현재 연체 여부',
  `policy_finance_usage` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정책서민금융 이용 여부',
  `financial_education_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '금융교육 이수 여부',
  `desired_support_purpose` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '희망 금융지원 목적',
  `desired_amount` decimal(19,2) DEFAULT NULL COMMENT '희망 지원금액',
  `monthly_saving_capacity` decimal(19,2) DEFAULT NULL COMMENT '월 저축 가능금액',
  `priority_preference` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품 선택 우선요소',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
  `north_korean_defector` tinyint(1) NOT NULL DEFAULT '0',
  `child_headed_household` tinyint(1) NOT NULL DEFAULT '0',
  `earned_income_tax_credit_recipient` tinyint(1) NOT NULL DEFAULT '0',
  `basic_pension_recipient` tinyint(1) NOT NULL DEFAULT '0',
  `disability_benefit_recipient` tinyint(1) NOT NULL DEFAULT '0',
  `household_annual_income` decimal(19,2) DEFAULT NULL,
  `homeless_household` tinyint(1) DEFAULT NULL,
  `household_head` tinyint(1) DEFAULT NULL,
  `jeonse_fraud_victim` tinyint(1) NOT NULL DEFAULT '0',
  `household_net_asset_amount` decimal(19,2) DEFAULT NULL,
  `prospective_household_head` tinyint(1) DEFAULT NULL,
  `first_time_home_buyer` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`policy_recommendation_profile_id`),
  UNIQUE KEY `uk_policy_recommendation_profile_user` (`user_id`),
  UNIQUE KEY `uk_policy_recommendation_profile_user_id` (`user_id`),
  CONSTRAINT `fk_policy_recommendation_profile_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='맞춤 정책금융상품 추천 설문 프로필';


CREATE TABLE `lifecycle_base_profile` (
  `lifecycle_base_profile_id` bigint NOT NULL AUTO_INCREMENT COMMENT '생애주기 기본 생활정보 식별자',
  `user_id` bigint NOT NULL COMMENT '회원 식별자',
  `monthly_living_expense` decimal(19,2) NOT NULL COMMENT '현재 월평균 생활비',
  `current_housing_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '현재 주거형태: FAMILY/MONTHLY_RENT/JEONSE/OWN',
  `current_monthly_housing_expense` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '현재 월 주거비',
  `industry_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '산업군 코드',
  `salary_growth_scenario` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BASE' COMMENT '급여상승 시나리오: CONSERVATIVE/BASE/OPTIMISTIC/CUSTOM',
  `custom_salary_growth_rate` decimal(9,6) DEFAULT NULL COMMENT 'CUSTOM 선택 시 직접 입력한 연평균 급여상승률',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
  PRIMARY KEY (`lifecycle_base_profile_id`),
  UNIQUE KEY `uk_lifecycle_base_profile_user` (`user_id`),
  CONSTRAINT `fk_lifecycle_base_profile_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `lifecycle_event` (
  `lifecycle_event_id` bigint NOT NULL AUTO_INCREMENT COMMENT '생애주기 이벤트 식별자',
  `lifecycle_scenario_id` bigint NOT NULL COMMENT '소속 생애주기 시나리오 식별자',
  `event_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '이벤트 종류: MARRIAGE/CHILDBIRTH/VEHICLE_PURCHASE/MONTHLY_RENT/JEONSE/HOME_PURCHASE/REPAYMENT',
  `event_order` int NOT NULL COMMENT '시나리오 내 이벤트 순서',
  `target_date` date NOT NULL COMMENT '이벤트 발생 예정일',
  `lifestyle_level` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '생활수준: PRACTICAL/AVERAGE/RELAXED/PREMIUM/CUSTOM',
  `survey_data` json NOT NULL COMMENT '이벤트별 상세 설문 데이터',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
  PRIMARY KEY (`lifecycle_event_id`),
  UNIQUE KEY `uk_lifecycle_event_order` (`lifecycle_scenario_id`,`event_order`),
  CONSTRAINT `fk_lifecycle_event_scenario` FOREIGN KEY (`lifecycle_scenario_id`) REFERENCES `lifecycle_scenario` (`lifecycle_scenario_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `lifecycle_reference` (
  `lifecycle_reference_id` bigint NOT NULL AUTO_INCREMENT COMMENT '생애주기 기준자료 식별자',
  `event_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'MARRIAGE, CHILDBIRTH, VEHICLE_PURCHASE 등',
  `reference_type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'TOTAL_COST, MEAL_COST_PER_GUEST 등',
  `region_sido` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '시도',
  `region_sigungu` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '시군구',
  `lifestyle_level` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PRACTICAL, AVERAGE, RELAXED, PREMIUM',
  `housing_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'APARTMENT, VILLA, OFFICETEL 등',
  `area_sqm` decimal(8,2) DEFAULT NULL COMMENT '전용면적 기준값',
  `amount_range_min` decimal(19,2) DEFAULT NULL COMMENT '금액 조건 최소값',
  `amount_range_max` decimal(19,2) DEFAULT NULL COMMENT '금액 조건 최대값',
  `guest_count_min` int DEFAULT NULL COMMENT '하객 수 최소 구간',
  `guest_count_max` int DEFAULT NULL COMMENT '하객 수 최대 구간',
  `vehicle_class` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'COMPACT, SMALL, SEMI_MIDSIZE, MIDSIZE, LARGE, SUV',
  `vehicle_condition` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'NEW, USED',
  `child_order` int DEFAULT NULL COMMENT '첫째=1, 둘째=2, 셋째=3, 넷째 이상=4',
  `loan_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'MORTGAGE, JEONSE, CREDIT, VEHICLE, POLICY',
  `calculation_unit` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'KRW, KRW_PER_MONTH, KRW_PER_GUEST, COUNT, RATE',
  `amount_value` decimal(19,2) DEFAULT NULL COMMENT '금액 기준값',
  `rate_value` decimal(9,6) DEFAULT NULL COMMENT '비율 기준값',
  `numeric_value` decimal(19,4) DEFAULT NULL COMMENT '기타 숫자형 기준값',
  `reference_year` int NOT NULL COMMENT '자료 기준연도',
  `reference_month` int DEFAULT NULL COMMENT '자료 기준월',
  `source_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '출처기관',
  `source_title` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '자료명',
  `source_url` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '원문 URL',
  `source_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'OFFICIAL, PUBLIC_SURVEY, PRIVATE_SURVEY, INTERNAL',
  `note` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '적용조건 및 설명',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lifecycle_reference_id`),
  KEY `idx_lifecycle_reference_lookup` (`event_type`,`reference_type`,`lifestyle_level`,`region_sido`,`region_sigungu`),
  KEY `idx_lifecycle_reference_detail_lookup` (`event_type`,`reference_type`,`region_sido`,`region_sigungu`,`lifestyle_level`,`housing_type`,`area_sqm`,`vehicle_class`,`vehicle_condition`,`child_order`,`loan_type`),
  KEY `idx_lifecycle_reference_guest_lookup` (`event_type`,`reference_type`,`region_sido`,`guest_count_min`,`guest_count_max`),
  KEY `idx_lifecycle_reference_amount_range_lookup` (`event_type`,`reference_type`,`amount_range_min`,`amount_range_max`),
  CONSTRAINT `chk_lifecycle_reference_month` CHECK (((`reference_month` is null) or (`reference_month` between 1 and 12))),
  CONSTRAINT `chk_lifecycle_reference_value` CHECK (((((`amount_value` is not null) + (`rate_value` is not null)) + (`numeric_value` is not null)) = 1))
) ENGINE=InnoDB AUTO_INCREMENT=1494 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `lifecycle_scenario` (
  `lifecycle_scenario_id` bigint NOT NULL AUTO_INCREMENT COMMENT '생애주기 시나리오 식별자',
  `user_id` bigint NOT NULL COMMENT '회원 식별자',
  `scenario_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '시나리오명',
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '시나리오 설명',
  `base_date` date NOT NULL COMMENT '시뮬레이션 시작 기준일',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE' COMMENT '시나리오 상태: ACTIVE/COMPLETED/DELETED',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
  PRIMARY KEY (`lifecycle_scenario_id`),
  KEY `fk_lifecycle_scenario_user` (`user_id`),
  CONSTRAINT `fk_lifecycle_scenario_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE app_user (
    user_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    login_email   VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    user_name     VARCHAR(50) NOT NULL,
    phone_number  VARCHAR(20) NOT NULL,
    birth_date    DATE NOT NULL,
    user_status   VARCHAR(20) NOT NULL,
    user_role     VARCHAR(20) NOT NULL,
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE social_user (
    social_user_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id          BIGINT NOT NULL,
    provider         VARCHAR(20) NOT NULL,
    provider_user_id VARCHAR(255) NOT NULL,
    provider_email   VARCHAR(255) NOT NULL,
    created_at       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_social_user_app_user
        FOREIGN KEY (user_id)
        REFERENCES app_user(user_id)
        ON DELETE CASCADE,

    CONSTRAINT uk_social_provider_user
        UNIQUE (provider, provider_user_id),

    CONSTRAINT uk_social_user_provider
        UNIQUE (user_id, provider)
);


CREATE TABLE mydata_connection
(
    connection_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,

    connection_status VARCHAR(20) NOT NULL DEFAULT 'CONNECTED',

    connected_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    disconnected_at DATETIME NULL,

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uk_mydata_connection_user UNIQUE (user_id),

    CONSTRAINT fk_mydata_connection_app_user
        FOREIGN KEY (user_id)
        REFERENCES app_user (user_id)
        ON DELETE CASCADE
);


CREATE TABLE user_financial_profile (
    user_financial_profile_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id                   BIGINT NOT NULL,
    annual_income             DECIMAL(19, 2) NOT NULL,
    income_type               VARCHAR(30) NOT NULL,
    employment_status         VARCHAR(30) NOT NULL,
    credit_score              INT NULL,
    liquid_asset_amount       DECIMAL(19, 2) NOT NULL DEFAULT 0,
    created_at                DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                                         ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (user_financial_profile_id),

    CONSTRAINT uk_user_financial_profile_user
        UNIQUE (user_id),

    CONSTRAINT fk_user_financial_profile_user
        FOREIGN KEY (user_id)
        REFERENCES app_user (user_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_user_annual_income
        CHECK (annual_income >= 0),

    CONSTRAINT chk_user_liquid_asset_amount
        CHECK (liquid_asset_amount >= 0),

    CONSTRAINT chk_user_credit_score
        CHECK (credit_score IS NULL OR credit_score BETWEEN 1 AND 1000)
);



CREATE TABLE loan_account (
    loan_account_id BIGINT NOT NULL AUTO_INCREMENT,

    connection_id BIGINT NOT NULL,

    external_loan_key VARCHAR(100),

    loan_type VARCHAR(30),

    principal_amount DECIMAL(19,2),
    current_balance DECIMAL(19,2),

    interest_rate DECIMAL(9,6),

    rate_type VARCHAR(20),
    repayment_type VARCHAR(30),

    disbursed_at DATE,
    maturity_at DATE,

    loan_status VARCHAR(20),

    data_as_of_at DATETIME,
    updated_at DATETIME,

    prepayment_fee_rate DECIMAL(7,4),
    prepayment_fee_end_date DATE,

    PRIMARY KEY (loan_account_id),

    CONSTRAINT fk_loan_account_connection
        FOREIGN KEY (connection_id)
        REFERENCES mydata_connection(connection_id)
);



CREATE TABLE loan_product (
    loan_product_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '사용자별 추천 대출상품 식별자',

    catalog_product_id BIGINT NOT NULL
        COMMENT '추천 근거가 된 상품 카탈로그 식별자',

    product_name VARCHAR(150) NOT NULL
        COMMENT '추천 당시 상품명',

    loan_type VARCHAR(30) NOT NULL
        COMMENT 'MORTGAGE, JEONSE, CREDIT',

    min_rate DECIMAL(9,6) DEFAULT NULL
        COMMENT '추천 당시 최저금리',

    max_rate DECIMAL(9,6) DEFAULT NULL
        COMMENT '추천 당시 최고금리',

    max_limit_amount DECIMAL(19,2) DEFAULT NULL
        COMMENT '사용자 기준 예상 최대 대출한도',

    max_period_months INT DEFAULT NULL
        COMMENT '사용자 기준 최대 대출기간 개월',

    target_description VARCHAR(300) DEFAULT NULL
        COMMENT '추천 대상 및 추천 근거',

    active TINYINT(1) NOT NULL DEFAULT 1
        COMMENT '추천 결과 활성 여부',

    institution_name VARCHAR(100) NOT NULL
        COMMENT '추천 당시 금융기관명',

    user_financial_profile_id BIGINT NOT NULL
        COMMENT '추천 대상 사용자 금융프로필 식별자',

    recommendation_rank INT DEFAULT NULL
        COMMENT '현재 사용자·대출유형 추천 결과 안의 표시 순위. 총상환액, 월 납입액, 예상 비교금리 순으로 정렬한 Top 5의 1~5위를 저장',

    recommended_rate DECIMAL(9,6) DEFAULT NULL
        COMMENT '추천 비용 계산에 실제 사용한 연 예상 비교금리(%). 신용대출은 사용자 신용점수 구간 공시금리, 주택·전세대출은 선택 조건에 맞는 옵션 대표금리이며 실제 약정금리가 아님',

    loan_purpose VARCHAR(40) DEFAULT NULL
        COMMENT '사용자가 선택한 대출 목적 코드. 예: CREDIT_LIVING, CREDIT_REFINANCE, MORTGAGE_HOME_PURCHASE, MORTGAGE_LIVING_STABILITY, JEONSE_DEPOSIT',

    requested_amount DECIMAL(19,2) DEFAULT NULL
        COMMENT '추천 시뮬레이션에 사용한 사용자 희망 대출원금(원)',

    requested_term_months INT DEFAULT NULL
        COMMENT '추천 시뮬레이션에 사용한 희망 상환기간(개월)',

    calculation_method VARCHAR(40) DEFAULT NULL
        COMMENT '월 납입액·총이자 계산에 사용한 상환 가정 코드. EQUAL_PRINCIPAL_INTEREST, EQUAL_PRINCIPAL, BULLET',

    estimated_monthly_payment DECIMAL(19,2) DEFAULT NULL
        COMMENT '입력 금액·기간·recommended_rate로 계산한 대표 월 부담액(원)',

    estimated_total_interest DECIMAL(19,2) DEFAULT NULL
        COMMENT '입력 금액·기간·상환 가정으로 계산한 예상 총이자(원)',

    estimated_total_cost DECIMAL(19,2) DEFAULT NULL
        COMMENT '추천 정렬에 사용하는 예상 총상환액(원). requested_amount와 estimated_total_interest의 합',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '추천 생성일시',

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '수정일시',

    PRIMARY KEY (loan_product_id),

    UNIQUE KEY uk_loan_product_profile_catalog (
        user_financial_profile_id,
        catalog_product_id
    ),

    KEY idx_loan_product_catalog (
        catalog_product_id
    ),

    KEY idx_loan_product_financial_profile (
        user_financial_profile_id
    ),

    KEY idx_loan_product_profile_type_active (
        user_financial_profile_id,
        loan_type,
        active
    ),

    CONSTRAINT fk_recommended_loan_catalog
        FOREIGN KEY (catalog_product_id)
        REFERENCES loan_product_catalog (catalog_product_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_loan_product_financial_profile
        FOREIGN KEY (user_financial_profile_id)
        REFERENCES user_financial_profile (user_financial_profile_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci
COMMENT='사용자 금융프로필별 최신 대출상품 추천 결과와 추천 당시 비교 조건·계산값을 저장하는 테이블';


ALTER TABLE loan_product
ADD CONSTRAINT fk_loan_product_financial_profile
FOREIGN KEY (user_financial_profile_id)
REFERENCES user_financial_profile (user_financial_profile_id)
ON DELETE CASCADE
ON UPDATE CASCADE;




-- =========================================================
-- 1. 외부 대출상품 카탈로그
-- =========================================================

CREATE TABLE loan_product_catalog (
    catalog_product_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '외부 대출상품 카탈로그 식별자',

    source_type VARCHAR(30) NOT NULL
        COMMENT 'FINLIFE_MORTGAGE, FINLIFE_JEONSE, FINLIFE_CREDIT',

    source_product_key VARCHAR(255) NOT NULL
        COMMENT '외부 출처 기준 상품 식별키',

    source_finance_code VARCHAR(30) NULL
        COMMENT '외부 금융회사 코드',

    source_product_code VARCHAR(100) NULL
        COMMENT '외부 금융상품 코드',

    source_product_subtype VARCHAR(20) NOT NULL DEFAULT ''
        COMMENT '외부 상품 세부유형',

    disclosure_month CHAR(6) NULL
        COMMENT '공시 제출월 YYYYMM',

    product_name VARCHAR(150) NOT NULL
        COMMENT '상품명',

    loan_type VARCHAR(30) NOT NULL
        COMMENT 'MORTGAGE, JEONSE, CREDIT',

    min_rate DECIMAL(9,6) NULL
        COMMENT '상품 옵션 중 최저금리',

    max_rate DECIMAL(9,6) NULL
        COMMENT '상품 옵션 중 최고금리',

    max_limit_amount DECIMAL(19,2) NULL
        COMMENT '상품 최대 대출한도',

    max_period_months INT NULL
        COMMENT '상품 최대 대출기간 개월',

    target_description VARCHAR(300) NULL
        COMMENT '상품 대상 또는 상품 유형 설명',

    active TINYINT(1) NOT NULL DEFAULT 1
        COMMENT '현재 조회 대상 여부',

    institution_name VARCHAR(100) NOT NULL
        COMMENT '금융기관명',

    institution_id BIGINT NULL
        COMMENT '서비스 금융기관 식별자',

    join_way VARCHAR(300) NULL
        COMMENT '가입방법',

    disclosure_start_date DATE NULL
        COMMENT '공시 시작일',

    disclosure_end_date DATE NULL
        COMMENT '공시 종료일',

    source_submitted_at DATETIME NULL
        COMMENT '외부 금융회사 제출일시',

    source_url VARCHAR(500) NULL
        COMMENT '외부 API 또는 원천 URL',

    collected_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '외부 API 수집일시',

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '수정일시',

    PRIMARY KEY (catalog_product_id),

    CONSTRAINT uk_loan_product_catalog_source
        UNIQUE (
            source_type,
            source_product_key,
            source_product_subtype
        ),

    INDEX idx_loan_product_catalog_type (
        loan_type
    ),

    INDEX idx_loan_product_catalog_type_active (
        loan_type,
        active
    ),

    INDEX idx_loan_product_catalog_institution (
        institution_name
    ),

    INDEX idx_loan_product_catalog_source_codes (
        source_finance_code,
        source_product_code
    )
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '외부 대출상품 카탈로그';


-- =========================================================
-- 2. 주택담보·전세대출 상품 상세
-- catalog_product_id가 PK이면서 FK인 식별 관계
-- =========================================================

CREATE TABLE housing_loan_product_detail (
    catalog_product_id BIGINT NOT NULL
        COMMENT '외부 대출상품 카탈로그 식별자',

    loan_incidental_expense TEXT NULL
        COMMENT '대출 부대비용',

    early_repayment_fee_text TEXT NULL
        COMMENT '중도상환수수료 원문',

    delinquency_rate_text TEXT NULL
        COMMENT '연체이자율 원문',

    loan_limit_text TEXT NULL
        COMMENT '대출한도 원문',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '생성일시',

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '수정일시',

    PRIMARY KEY (catalog_product_id),

    CONSTRAINT fk_housing_loan_detail_catalog
        FOREIGN KEY (catalog_product_id)
        REFERENCES loan_product_catalog (catalog_product_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '주택계열 대출상품 상세';


-- =========================================================
-- 3. 주택담보·전세대출 상품 옵션
-- =========================================================

CREATE TABLE housing_loan_product_option (
    housing_loan_product_option_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '주택계열 대출상품 옵션 식별자',

    catalog_product_id BIGINT NOT NULL
        COMMENT '외부 대출상품 카탈로그 식별자',

    collateral_type_code VARCHAR(10) NOT NULL DEFAULT ''
        COMMENT '담보유형 코드',

    collateral_type_name VARCHAR(50) NULL
        COMMENT '담보유형명',

    repayment_type_code VARCHAR(10) NOT NULL
        COMMENT '상환방식 코드',

    repayment_type_name VARCHAR(50) NOT NULL
        COMMENT '상환방식명',

    rate_type_code VARCHAR(10) NOT NULL
        COMMENT '금리유형 코드',

    rate_type_name VARCHAR(50) NOT NULL
        COMMENT '금리유형명',

    min_rate DECIMAL(9,6) NULL
        COMMENT '최저금리',

    max_rate DECIMAL(9,6) NULL
        COMMENT '최고금리',

    average_rate DECIMAL(9,6) NULL
        COMMENT '평균금리',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '생성일시',

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '수정일시',

    PRIMARY KEY (housing_loan_product_option_id),

    INDEX idx_housing_loan_option_catalog (
        catalog_product_id
    ),

    CONSTRAINT fk_housing_loan_option_catalog
        FOREIGN KEY (catalog_product_id)
        REFERENCES loan_product_catalog (catalog_product_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '주택계열 대출상품 금리옵션';


-- =========================================================
-- 4. 신용대출 상품 상세
-- catalog_product_id가 PK이면서 FK인 식별 관계
-- =========================================================

CREATE TABLE credit_loan_product_detail (
    catalog_product_id BIGINT NOT NULL
        COMMENT '외부 대출상품 카탈로그 식별자',

    credit_bureau_name VARCHAR(30) NULL
        COMMENT '신용평가회사명',

    credit_product_type_code VARCHAR(10) NOT NULL
        COMMENT '신용대출 상품유형 코드',

    credit_product_type_name VARCHAR(100) NOT NULL
        COMMENT '신용대출 상품유형명',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '생성일시',

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '수정일시',

    PRIMARY KEY (catalog_product_id),

    CONSTRAINT fk_credit_loan_detail_catalog
        FOREIGN KEY (catalog_product_id)
        REFERENCES loan_product_catalog (catalog_product_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '신용대출 상품 상세';


-- =========================================================
-- 5. 신용대출 신용점수 구간별 금리 옵션
-- =========================================================

CREATE TABLE credit_loan_rate_option (
    credit_loan_rate_option_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '신용대출 금리 옵션 식별자',

    catalog_product_id BIGINT NOT NULL
        COMMENT '외부 대출상품 카탈로그 식별자',

    rate_category_code VARCHAR(10) NOT NULL
        COMMENT '금리구분 코드',

    rate_category_name VARCHAR(50) NOT NULL
        COMMENT '금리구분명',

    rate_over_900 DECIMAL(9,6) NULL
        COMMENT '900점 초과 구간 금리',

    rate_801_900 DECIMAL(9,6) NULL
        COMMENT '801점 이상 900점 이하 구간 금리',

    rate_701_800 DECIMAL(9,6) NULL
        COMMENT '701점 이상 800점 이하 구간 금리',

    rate_601_700 DECIMAL(9,6) NULL
        COMMENT '601점 이상 700점 이하 구간 금리',

    rate_501_600 DECIMAL(9,6) NULL
        COMMENT '501점 이상 600점 이하 구간 금리',

    rate_401_500 DECIMAL(9,6) NULL
        COMMENT '401점 이상 500점 이하 구간 금리',

    rate_301_400 DECIMAL(9,6) NULL
        COMMENT '301점 이상 400점 이하 구간 금리',

    rate_300_or_below DECIMAL(9,6) NULL
        COMMENT '300점 이하 구간 금리',

    average_rate DECIMAL(9,6) NULL
        COMMENT '평균금리',

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '생성일시',

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '수정일시',

    PRIMARY KEY (credit_loan_rate_option_id),

    INDEX idx_credit_loan_rate_option_catalog (
        catalog_product_id
    ),

    CONSTRAINT fk_credit_loan_rate_option_catalog
        FOREIGN KEY (catalog_product_id)
        REFERENCES loan_product_catalog (catalog_product_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '신용대출 상품 금리옵션';


-- =========================================================
-- 6. 기존 사용자별 추천 결과 테이블 loan_product 연결
--
-- loan_product는 재생성하지 않음
-- catalog_product_id 컬럼과 인덱스가 이미 존재한다는 기준
-- =========================================================

ALTER TABLE loan_product
    ADD CONSTRAINT fk_recommended_loan_catalog
        FOREIGN KEY (catalog_product_id)
        REFERENCES loan_product_catalog (catalog_product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT;
        
        
SET NAMES utf8mb4;

-- =========================================================
-- 1. 여유자금 운용 가이드 마스터
-- 선행 조건: app_user 테이블이 먼저 존재해야 한다.
-- =========================================================

CREATE TABLE IF NOT EXISTS surplus_fund_plan (
    surplus_fund_plan_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '여유자금 운용 가이드 결과 식별자',

    user_id BIGINT NOT NULL
        COMMENT '가이드를 생성한 사용자 식별자(app_user.user_id 참조)',

    operation_amount DECIMAL(19,2) NOT NULL
        COMMENT '남경 누나 담당 단계에서 계산되어 전달된 실제 운용 가능 여유자금',

    amount_source VARCHAR(40) NOT NULL
        DEFAULT 'SURPLUS_FUND_CALCULATION'
        COMMENT '운용금액 출처. 현재값은 SURPLUS_FUND_CALCULATION',

    investment_purpose VARCHAR(30) NOT NULL
        COMMENT '설문 1: 운용 목적',

    investment_period_months INT NOT NULL
        COMMENT '설문 2: 예상 운용기간(개월)',

    loss_tolerance_level VARCHAR(30) NOT NULL
        COMMENT '설문 3: 사용자가 감내할 수 있는 손실 수준',

    liquidity_need VARCHAR(20) NOT NULL
        COMMENT '설문 4: 자금을 다시 회수해야 하는 유동성 필요 수준',

    experience_level VARCHAR(30) NOT NULL
        COMMENT '설문 5: ETF·펀드 투자 경험 및 위험 이해 수준',

    surplus_amount_confirmed TINYINT NOT NULL
        COMMENT '사용자가 계산된 여유자금 금액을 확인했는지 여부(0/1)',

    guide_notice_confirmed TINYINT NOT NULL
        COMMENT '교육용 모의 운용 가이드 고지 확인 여부(0/1)',

    investment_style VARCHAR(20) NOT NULL
        COMMENT '설문을 내부 규칙으로 분류한 성향(STABLE/BALANCED/AGGRESSIVE)',

    rule_version VARCHAR(30) NOT NULL
        COMMENT '성향 분류 및 자산 배분 규칙 버전. 예: GUIDE_V1.0',

    confirmed_at DATETIME NOT NULL
        COMMENT '금액 및 안내문 확인 후 설문을 최종 제출한 시각',

    created_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        COMMENT '가이드 결과 DB 생성 시각',

    PRIMARY KEY (surplus_fund_plan_id),

    KEY idx_surplus_plan_user_created (
        user_id,
        created_at
    ),

    CONSTRAINT fk_surplus_plan_user
        FOREIGN KEY (user_id)
        REFERENCES app_user (user_id),

    CONSTRAINT chk_surplus_plan_confirmations
        CHECK (
            surplus_amount_confirmed IN (0, 1)
            AND guide_notice_confirmed IN (0, 1)
        ),

    CONSTRAINT chk_surplus_plan_experience
        CHECK (
            experience_level IN (
                'NONE',
                'LIMITED',
                'UNDERSTANDS_RISK'
            )
        ),

    CONSTRAINT chk_surplus_plan_liquidity
        CHECK (
            liquidity_need IN (
                'LOW',
                'MEDIUM',
                'HIGH'
            )
        ),

    CONSTRAINT chk_surplus_plan_loss_tolerance
        CHECK (
            loss_tolerance_level IN (
                'NO_LOSS',
                'WITHIN_5_PERCENT',
                'WITHIN_15_PERCENT',
                'OVER_15_PERCENT'
            )
        ),

    CONSTRAINT chk_surplus_plan_operation_amount
        CHECK (operation_amount > 0),

    CONSTRAINT chk_surplus_plan_period
        CHECK (investment_period_months BETWEEN 1 AND 600),

    CONSTRAINT chk_surplus_plan_purpose
        CHECK (
            investment_purpose IN (
                'PRINCIPAL_PROTECTION',
                'STABLE_RETURN',
                'BALANCED_GROWTH',
                'CAPITAL_GROWTH'
            )
        ),

    CONSTRAINT chk_surplus_plan_style
        CHECK (
            investment_style IN (
                'STABLE',
                'BALANCED',
                'AGGRESSIVE'
            )
        )
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '사용자 여유자금, 5개 성향 설문, 최종 투자성향을 저장하는 운용 가이드 마스터';


-- =========================================================
-- 2. 여유자금 자산군별 배분 결과
-- =========================================================

CREATE TABLE IF NOT EXISTS surplus_fund_plan_allocation (
    surplus_fund_plan_allocation_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '자산군별 배분 결과 식별자',

    surplus_fund_plan_id BIGINT NOT NULL
        COMMENT '상위 운용 가이드 식별자(surplus_fund_plan 참조)',

    asset_type VARCHAR(20) NOT NULL
        COMMENT '배분 자산군(CASH: 현금성 대기자금, ETF, FUND)',

    allocation_ratio DECIMAL(5,2) NOT NULL
        COMMENT '해당 자산군 배분비율(%). 한 가이드의 합계는 서비스에서 100%로 검증',

    allocation_amount DECIMAL(19,2) NOT NULL
        COMMENT '운용 가능 금액에 배분비율을 적용해 계산한 자산군별 금액',

    created_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        COMMENT '자산군 배분 결과 DB 생성 시각',

    PRIMARY KEY (surplus_fund_plan_allocation_id),

    UNIQUE KEY uk_plan_asset_type (
        surplus_fund_plan_id,
        asset_type
    ),

    CONSTRAINT fk_allocation_plan
        FOREIGN KEY (surplus_fund_plan_id)
        REFERENCES surplus_fund_plan (surplus_fund_plan_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_allocation_amount
        CHECK (allocation_amount >= 0),

    CONSTRAINT chk_allocation_asset_type
        CHECK (
            asset_type IN (
                'CASH',
                'ETF',
                'FUND'
            )
        ),

    CONSTRAINT chk_allocation_ratio
        CHECK (
            allocation_ratio >= 0
            AND allocation_ratio <= 100
        )
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '운용 가이드별 CASH·ETF·FUND 자산군 배분비율과 금액';


SET NAMES utf8mb4;

-- =========================================================
-- 3. 투자상품 공통 카탈로그
-- =========================================================

CREATE TABLE IF NOT EXISTS investment_product_catalog (
    investment_product_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '서비스 DB 내부 투자상품 식별자',

    product_type VARCHAR(20) NOT NULL
        COMMENT '상품 유형: ETF 또는 FUND',

    product_code VARCHAR(50) NOT NULL
        COMMENT '외부 API 상품 단축코드. ETF는 srtnCd',

    isin_code VARCHAR(20) DEFAULT NULL
        COMMENT '국제증권식별코드. 외부 API의 isinCd',

    product_name VARCHAR(300) NOT NULL
        COMMENT '상품명. 외부 API의 itmsNm',

    provider_name VARCHAR(150) DEFAULT NULL
        COMMENT '운용사 또는 금융기관명. 공식 API에서 없으면 NULL',

    category VARCHAR(100) DEFAULT NULL
        COMMENT '상품 분류. 해당 외부 API에 값이 없으면 NULL',

    source_type VARCHAR(50) NOT NULL
        COMMENT '데이터 출처. ETF는 FSC_SECURITIES_PRICE_API',

    active TINYINT(1) NOT NULL
        DEFAULT 1
        COMMENT '화면 노출 여부: 1 노출, 0 미노출',

    last_synced_at DATETIME DEFAULT NULL
        COMMENT '외부 API에서 마지막으로 동기화한 시각',

    created_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        COMMENT '최초 생성 시각',

    updated_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT '마지막 수정 시각',

    PRIMARY KEY (investment_product_id),

    UNIQUE KEY uk_investment_product_code_type (
        product_code,
        product_type
    ),

    UNIQUE KEY uk_investment_product_isin_type (
        isin_code,
        product_type
    ),

    KEY idx_investment_product_type_active (
        product_type,
        active
    ),

    KEY idx_investment_product_name (
        product_name
    ),

    CONSTRAINT chk_investment_product_active
        CHECK (active IN (0, 1)),

    CONSTRAINT chk_investment_product_type
        CHECK (
            product_type IN (
                'ETF',
                'FUND'
            )
        )
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'ETF와 펀드의 공통 상품 기본정보 카탈로그';


-- =========================================================
-- 4. ETF 최신 시세 상세정보
-- =========================================================

CREATE TABLE IF NOT EXISTS etf_product_detail (
    investment_product_id BIGINT NOT NULL
        COMMENT 'investment_product_catalog의 ETF 상품 식별자',

    price_base_date DATE NOT NULL
        COMMENT '시세 기준일자. 외부 API의 basDt',

    closing_price DECIMAL(19,4) DEFAULT NULL
        COMMENT '종가. 외부 API의 clpr',

    previous_day_change DECIMAL(19,4) DEFAULT NULL
        COMMENT '전일 대비 가격. 외부 API의 vs',

    fluctuation_rate DECIMAL(10,6) DEFAULT NULL
        COMMENT '등락률(%). 외부 API의 fltRt',

    nav DECIMAL(19,4) DEFAULT NULL
        COMMENT '순자산가치. 외부 API의 nav',

    opening_price DECIMAL(19,4) DEFAULT NULL
        COMMENT '시가. 외부 API의 mkp',

    high_price DECIMAL(19,4) DEFAULT NULL
        COMMENT '고가. 외부 API의 hipr',

    low_price DECIMAL(19,4) DEFAULT NULL
        COMMENT '저가. 외부 API의 lopr',

    trading_volume BIGINT DEFAULT NULL
        COMMENT '거래량. 외부 API의 trqu',

    trading_value DECIMAL(25,2) DEFAULT NULL
        COMMENT '거래대금. 외부 API의 trPrc',

    listed_share_count BIGINT DEFAULT NULL
        COMMENT '상장좌수. 외부 API의 stLstgCnt',

    market_cap DECIMAL(25,2) DEFAULT NULL
        COMMENT '시가총액. 외부 API의 mrktTotAmt',

    net_asset_total_amount DECIMAL(25,2) DEFAULT NULL
        COMMENT '순자산총액. 외부 API의 nPptTotAmt',

    base_index_name VARCHAR(300) DEFAULT NULL
        COMMENT '기초지수명. 외부 API의 bssIdxIdxNm',

    base_index_close DECIMAL(19,4) DEFAULT NULL
        COMMENT '기초지수 종가. 외부 API의 bssIdxClpr',

    updated_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
        COMMENT 'ETF 시세 마지막 갱신 시각',

    PRIMARY KEY (investment_product_id),

    KEY idx_etf_price_base_date (
        price_base_date
    ),

    KEY idx_etf_trading_value (
        trading_value
    ),

    KEY idx_etf_market_cap (
        market_cap
    ),

    CONSTRAINT fk_etf_detail_catalog
        FOREIGN KEY (investment_product_id)
        REFERENCES investment_product_catalog (investment_product_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_etf_non_negative_prices
        CHECK (
            (closing_price IS NULL OR closing_price >= 0)
            AND (nav IS NULL OR nav >= 0)
            AND (opening_price IS NULL OR opening_price >= 0)
            AND (high_price IS NULL OR high_price >= 0)
            AND (low_price IS NULL OR low_price >= 0)
        ),

    CONSTRAINT chk_etf_non_negative_trade
        CHECK (
            (trading_volume IS NULL OR trading_volume >= 0)
            AND (trading_value IS NULL OR trading_value >= 0)
            AND (listed_share_count IS NULL OR listed_share_count >= 0)
            AND (market_cap IS NULL OR market_cap >= 0)
            AND (
                net_asset_total_amount IS NULL
                OR net_asset_total_amount >= 0
            )
        )
)
ENGINE = InnoDB
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '금융위원회 ETF API에서 수집한 상품별 최신 시세정보';




DROP TABLE IF EXISTS surplus_fund_calculation;

CREATE TABLE surplus_fund_calculation
(
    surplus_fund_calculation_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT NOT NULL,
    connection_id BIGINT NOT NULL,

    /* 계좌 */
    total_current_balance DECIMAL(19,2) NOT NULL,
    selected_account_balance DECIMAL(19,2) NOT NULL,

    /* 예: 1,4 */
    selected_account_ids VARCHAR(500) NOT NULL,

    /* 다음 수입일 */
    estimated_next_income_date DATE NULL,
    adjusted_next_income_date DATE NULL,

    /* 생활비 */
    estimated_living_expense DECIMAL(19,2) NOT NULL,
    adjusted_living_expense DECIMAL(19,2) NOT NULL,

    /* 예정 지출 */
    estimated_scheduled_expense DECIMAL(19,2) NOT NULL,
    adjusted_scheduled_expense DECIMAL(19,2) NOT NULL,

    /* 비상자금 */
    recommended_emergency_fund DECIMAL(19,2) NOT NULL,
    adjusted_emergency_fund DECIMAL(19,2) NOT NULL,

    /* 계산 결과 */
    calculated_surplus_amount DECIMAL(19,2) NOT NULL,

    /* 사용자가 실제 운용하기로 확정한 금액 */
    final_surplus_amount DECIMAL(19,2) NOT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_surplus_fund_calculation_user
        FOREIGN KEY (user_id)
        REFERENCES app_user(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_surplus_fund_calculation_connection
        FOREIGN KEY (connection_id)
        REFERENCES mydata_connection(connection_id)
        ON DELETE CASCADE
);



	CREATE TABLE IF NOT EXISTS fund_product_detail (
	    fund_product_detail_id BIGINT NOT NULL AUTO_INCREMENT
	        COMMENT '펀드 상세정보 식별자',
	
	    investment_product_id BIGINT NOT NULL
	        COMMENT 'investment_product_catalog의 펀드 상품 식별자',
	
	    disclosure_base_date DATE NOT NULL
	        COMMENT '공시 데이터 기준일',
	
	    return_1_month DECIMAL(10,6) NULL
	        COMMENT '1개월 누적수익률(%)',
	
	    return_3_months DECIMAL(10,6) NULL
	        COMMENT '3개월 누적수익률(%)',
	
	    return_6_months DECIMAL(10,6) NULL
	        COMMENT '6개월 누적수익률(%)',
	
	    return_12_months DECIMAL(10,6) NULL
	        COMMENT '12개월 누적수익률(%)',
	
	    fund_grade TINYINT NULL
	        COMMENT '중소기업은행 제공 펀드등급',
	
	    upfront_fee_rate DECIMAL(10,6) NULL
	        COMMENT '선취수수료(%)',
	
	    total_expense_rate DECIMAL(10,6) NULL
	        COMMENT '총보수(%)',
	
	    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
	        COMMENT '최초 저장 시각',
	
	    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
	        ON UPDATE CURRENT_TIMESTAMP
	        COMMENT '마지막 수정 시각',
	
	    PRIMARY KEY (fund_product_detail_id),
	
	    UNIQUE KEY uk_fund_product_base_date (
	        investment_product_id,
	        disclosure_base_date
	    ),
	
	    KEY idx_fund_base_date (disclosure_base_date),
	    KEY idx_fund_grade (fund_grade),
	    KEY idx_fund_return_12_months (return_12_months),
	    KEY idx_fund_total_expense_rate (total_expense_rate),
	
	    CONSTRAINT fk_fund_detail_catalog
	        FOREIGN KEY (investment_product_id)
	        REFERENCES investment_product_catalog (investment_product_id)
	        ON DELETE CASCADE
	) ENGINE=InnoDB
	  DEFAULT CHARSET=utf8mb4
	  COLLATE=utf8mb4_0900_ai_ci
	  COMMENT='중소기업은행 CSV 기반 펀드 수익률·등급·수수료 정보';
	  
	  
	  
	  
	  -- ============================================================================
-- 여유자금 운용 기록(최종 레포트 구성요소) 저장 스키마
-- 적용 대상: MySQL 8 / shinvia_service
-- 선행 테이블:
--   app_user
--   surplus_fund_calculation
--   surplus_fund_plan
--   surplus_fund_plan_allocation
--   investment_product_catalog
--   etf_product_detail
-- ============================================================================

-- 설문 원문은 레포트에 저장하지 않고, 판정 결과를 설명하는 이유만 순서대로 보관한다.
CREATE TABLE IF NOT EXISTS surplus_fund_plan_reason (
    surplus_fund_plan_reason_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '운용성향 판정 이유 식별자',
    surplus_fund_plan_id BIGINT NOT NULL
        COMMENT '판정 이유가 속한 여유자금 운용계획',
    reason_order INT NOT NULL
        COMMENT '판정 이유 표시 순서(1부터 시작)',
    reason_text VARCHAR(500) NOT NULL
        COMMENT '사용자에게 표시한 판정 이유 문장',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '판정 이유 저장 시각',

    PRIMARY KEY (surplus_fund_plan_reason_id),
    UNIQUE KEY uk_surplus_plan_reason_order
        (surplus_fund_plan_id, reason_order),
    KEY idx_surplus_plan_reason_plan
        (surplus_fund_plan_id),

    CONSTRAINT fk_surplus_plan_reason_plan
        FOREIGN KEY (surplus_fund_plan_id)
        REFERENCES surplus_fund_plan (surplus_fund_plan_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_surplus_plan_reason_order
        CHECK (reason_order > 0)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci
  COMMENT='여유자금 운용성향 판정 이유';


-- 한 번의 완주된 흐름을 식별하는 루트 테이블이다.
-- 계산 결과와 운용계획은 기존의 insert-only 행을 참조하며, 표시 이름만 별도로 수정할 수 있다.
CREATE TABLE IF NOT EXISTS surplus_fund_guide_version (
    surplus_fund_guide_version_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '완주된 여유자금 운용 기록 식별자',
    user_id BIGINT NOT NULL
        COMMENT '운용 기록 소유 사용자',
    guide_version_no INT NOT NULL
        COMMENT '사용자별 운용 기록 버전 번호(1부터 증가)',
    guide_name VARCHAR(100) NOT NULL
        COMMENT '사용자가 이전 기록을 구분하는 표시 이름',
    surplus_fund_calculation_id BIGINT NOT NULL
        COMMENT '1단계 여유자금 계산 결과',
    surplus_fund_plan_id BIGINT NOT NULL
        COMMENT '2~3단계 운용성향 및 자산배분 결과',
    selected_etf_count TINYINT NOT NULL DEFAULT 0
        COMMENT '관심 ETF로 확정한 상품 수(0~4)',
    snapshot_schema_version VARCHAR(30) NOT NULL DEFAULT 'SURPLUS_GUIDE_V1.0'
        COMMENT '레포트 구성요소 스냅샷 스키마 버전',
    idempotency_key VARCHAR(64) NOT NULL
        COMMENT '최종 저장 중복 요청 방지 키',
    completed_at DATETIME NOT NULL
        COMMENT '사용자가 전체 흐름을 완료한 시각',
    name_updated_at DATETIME NULL
        COMMENT '표시 이름을 마지막으로 수정한 시각',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT 'DB 생성 시각',

    PRIMARY KEY (surplus_fund_guide_version_id),
    UNIQUE KEY uk_surplus_guide_user_version
        (user_id, guide_version_no),
    UNIQUE KEY uk_surplus_guide_user_idempotency
        (user_id, idempotency_key),
    UNIQUE KEY uk_surplus_guide_plan
        (surplus_fund_plan_id),
    KEY idx_surplus_guide_user_completed
        (user_id, completed_at),
    KEY idx_surplus_guide_calculation
        (surplus_fund_calculation_id),

    CONSTRAINT fk_surplus_guide_user
        FOREIGN KEY (user_id)
        REFERENCES app_user (user_id),
    CONSTRAINT fk_surplus_guide_calculation
        FOREIGN KEY (surplus_fund_calculation_id)
        REFERENCES surplus_fund_calculation (surplus_fund_calculation_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_surplus_guide_plan
        FOREIGN KEY (surplus_fund_plan_id)
        REFERENCES surplus_fund_plan (surplus_fund_plan_id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_surplus_guide_version_no
        CHECK (guide_version_no > 0),
    CONSTRAINT chk_surplus_guide_etf_count
        CHECK (selected_etf_count BETWEEN 0 AND 4)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci
  COMMENT='최종 레포트에서 참조할 완주된 여유자금 운용 기록';


-- ETF 카탈로그와 시세는 동기화 때 변경되므로 선택 당시 값을 복사한다.
-- source_investment_product_id에는 의도적으로 FK를 걸지 않는다.
-- 현재 상품이 비활성화·삭제되어도 과거 레포트가 유지되어야 하기 때문이다.
CREATE TABLE IF NOT EXISTS surplus_fund_guide_etf_snapshot (
    surplus_fund_guide_etf_snapshot_id BIGINT NOT NULL AUTO_INCREMENT
        COMMENT '관심 ETF 스냅샷 식별자',
    surplus_fund_guide_version_id BIGINT NOT NULL
        COMMENT '완주된 여유자금 운용 기록',
    source_investment_product_id BIGINT NOT NULL
        COMMENT '선택 당시 investment_product_catalog 식별자(추적용, FK 없음)',
    selection_order TINYINT NOT NULL
        COMMENT '사용자가 비교 담기에 넣은 순서(1~4)',

    product_code VARCHAR(50) NOT NULL,
    isin_code VARCHAR(20) NULL,
    product_name VARCHAR(300) NOT NULL,
    provider_name VARCHAR(150) NULL,
    category VARCHAR(100) NULL,
    source_type VARCHAR(50) NOT NULL,
    price_base_date DATE NOT NULL,
    closing_price DECIMAL(19,4) NULL,
    previous_day_change DECIMAL(19,4) NULL,
    fluctuation_rate DECIMAL(10,6) NULL,
    nav DECIMAL(19,4) NULL,
    opening_price DECIMAL(19,4) NULL,
    high_price DECIMAL(19,4) NULL,
    low_price DECIMAL(19,4) NULL,
    trading_volume BIGINT NULL,
    trading_value DECIMAL(25,2) NULL,
    listed_share_count BIGINT NULL,
    market_cap DECIMAL(25,2) NULL,
    net_asset_total_amount DECIMAL(25,2) NULL,
    base_index_name VARCHAR(300) NULL,
    base_index_close DECIMAL(19,4) NULL,
    product_last_synced_at DATETIME NULL,
    captured_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT '선택 상품 정보를 복사한 시각',

    PRIMARY KEY (surplus_fund_guide_etf_snapshot_id),
    UNIQUE KEY uk_surplus_guide_etf_order
        (surplus_fund_guide_version_id, selection_order),
    UNIQUE KEY uk_surplus_guide_etf_product
        (surplus_fund_guide_version_id, source_investment_product_id),

    CONSTRAINT fk_surplus_guide_etf_version
        FOREIGN KEY (surplus_fund_guide_version_id)
        REFERENCES surplus_fund_guide_version (surplus_fund_guide_version_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_surplus_guide_etf_order
        CHECK (selection_order BETWEEN 1 AND 4)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci
  COMMENT='완주 시점에 사용자가 관심 상품으로 선택한 ETF 정보 스냅샷';


-- 적용 확인
SHOW CREATE TABLE surplus_fund_plan_reason;
SHOW CREATE TABLE surplus_fund_guide_version;
SHOW CREATE TABLE surplus_fund_guide_etf_snapshot;





ALTER TABLE app_user
    ADD COLUMN household_size VARCHAR(10) NULL COMMENT '가구원수 자기입력 (1인/2인/3인/4인/5인이상), NULL이면 미입력';

CREATE TABLE kosis_household_net_worth (
    id                       BIGINT        NOT NULL AUTO_INCREMENT,
    household_size_code       VARCHAR(10)   NOT NULL COMMENT 'KOSIS 분류코드',
    household_size_label       VARCHAR(20)   NOT NULL COMMENT '전체/1인/2인/3인/4인/5인이상',
    survey_year                 VARCHAR(4)    NOT NULL,
    avg_income                    DECIMAL(19,2) NOT NULL COMMENT '평균 경상소득(전년도, 원)',
    median_income                  DECIMAL(19,2) NOT NULL COMMENT '중앙값 경상소득(전년도, 원)',
    avg_asset                        DECIMAL(19,2) NOT NULL COMMENT '평균 자산(원)',
    median_asset                      DECIMAL(19,2) NOT NULL COMMENT '중앙값 자산(원)',
    avg_debt                            DECIMAL(19,2) NOT NULL COMMENT '평균 부채(원)',
    median_debt                          DECIMAL(19,2) NOT NULL COMMENT '중앙값 부채(원)',
    avg_net_worth                           DECIMAL(19,2) NOT NULL COMMENT '평균 순자산액(원)',
    median_net_worth                         DECIMAL(19,2) NOT NULL COMMENT '중앙값 순자산액(원)',
    avg_household_head_age                     DECIMAL(5,2)  NULL,
    household_distribution_pct                   DECIMAL(5,2)  NULL,
    updated_at                                    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_household_size_year (household_size_code, survey_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2025년 가계금융복지조사 (KOSIS Open API 조회값, 만원 단위 원본을 원 단위로 환산)
INSERT INTO kosis_household_net_worth
(household_size_code, household_size_label, survey_year, avg_income, median_income, avg_asset, median_asset, avg_debt, median_debt, avg_net_worth, median_net_worth, avg_household_head_age, household_distribution_pct) VALUES
('B0600', '전체',    '2025',  74273161,  58000000, 566775030, 302700000,  95337998,  80000000, 471437032, 238600000, 55.25, 100.00),
('B0601', '1인',     '2025',  34232926,  27630000, 223024507,  97400000,  40186262,  45000000, 182838245,  74000000, 54.68,  32.05),
('B0602', '2인',     '2025',  66134009,  53230000, 604139885, 334000000,  82851610,  60000000, 521288274, 276300000, 60.81,  28.58),
('B0603', '3인',     '2025', 102715763,  87860000, 784881580, 502100000, 133654588, 100000000, 651226992, 390170000, 53.32,  20.21),
('B0604', '4인',     '2025', 124618067, 108330000, 864225350, 579500000, 165741772, 130000000, 698483578, 445970000, 49.83,  15.16),
('B0605', '5인이상',  '2025', 118714190, 101970000, 824591645, 509500000, 166008897, 124300000, 658582747, 373840000, 50.41,   4.00);

-- [009] 연령대별 순자산 벤치마크
CREATE TABLE kosis_age_group_net_worth (
    id BIGINT NOT NULL AUTO_INCREMENT,
    age_group_code VARCHAR(10) NOT NULL COMMENT 'KOSIS 분류코드',
    age_group_label VARCHAR(20) NOT NULL COMMENT '연령대 라벨',
    survey_year VARCHAR(4) NOT NULL,
    avg_household_head_age DECIMAL(5,2) NULL,
    household_distribution_pct DECIMAL(5,2) NULL,
    avg_income DECIMAL(19,2) NOT NULL,
    median_income DECIMAL(19,2) NOT NULL,
    avg_asset DECIMAL(19,2) NOT NULL,
    median_asset DECIMAL(19,2) NOT NULL,
    avg_debt DECIMAL(19,2) NOT NULL,
    median_debt DECIMAL(19,2) NOT NULL,
    avg_net_worth DECIMAL(19,2) NOT NULL,
    median_net_worth DECIMAL(19,2) NOT NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_age_group_year (age_group_code, survey_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO kosis_age_group_net_worth
(age_group_code, age_group_label, survey_year, avg_household_head_age, household_distribution_pct, avg_income, median_income, avg_asset, median_asset, avg_debt, median_debt, avg_net_worth, median_net_worth) VALUES
('B1600', '전체', '2025', 55.25, 100.00, 74273160.70, 58000000, 566775030.03, 302700000, 95337997.66, 80000000, 471437032.37, 238600000),
('B1601', '29세 이하', '2025', 27.03, 4.02, 45086143.17, 38730000, 154996831.43, 72600000, 47033064.24, 70000000, 107963767.18, 50000000),
('B1602', '30~39세', '2025', 34.80, 14.40, 73855159.50, 62190000, 359581763.37, 249100000, 108985041.56, 107320000, 250596721.82, 155850000),
('B1603', '40~49세', '2025', 44.50, 18.63, 93325199.39, 78010000, 627140632.27, 399900000, 143248344.68, 110000000, 483892287.58, 283840000),
('B1604', '50~59세', '2025', 54.67, 22.28, 94164316.63, 78050000, 662051160.92, 380050000, 110440736.84, 75000000, 551610424.08, 316850000),
('B1605', '60세 이상', '2025', 70.53, 40.66, 57672082.22, 39780000, 600954925.81, 280600000, 65042014.11, 50000000, 535912911.70, 250000000);

-- [010] 원리금상환액 컬럼과 값 보강
ALTER TABLE kosis_household_net_worth
    ADD COLUMN avg_debt_repayment DECIMAL(19,2) NOT NULL DEFAULT 0 COMMENT '평균 원리금상환액(전년도, 원)' AFTER avg_net_worth,
    ADD COLUMN median_debt_repayment DECIMAL(19,2) NOT NULL DEFAULT 0 COMMENT '중앙값 원리금상환액(전년도, 원)' AFTER avg_debt_repayment;
ALTER TABLE kosis_age_group_net_worth
    ADD COLUMN avg_debt_repayment DECIMAL(19,2) NOT NULL DEFAULT 0 COMMENT '평균 원리금상환액(전년도, 원)' AFTER avg_net_worth,
    ADD COLUMN median_debt_repayment DECIMAL(19,2) NOT NULL DEFAULT 0 COMMENT '중앙값 원리금상환액(전년도, 원)' AFTER avg_debt_repayment;
UPDATE kosis_household_net_worth SET avg_debt_repayment = 13276190.36, median_debt_repayment = 10060000 WHERE household_size_code = 'B0600';
UPDATE kosis_household_net_worth SET avg_debt_repayment = 5788937.76, median_debt_repayment = 6000000 WHERE household_size_code = 'B0601';
UPDATE kosis_household_net_worth SET avg_debt_repayment = 10939415.14, median_debt_repayment = 9000000 WHERE household_size_code = 'B0602';
UPDATE kosis_household_net_worth SET avg_debt_repayment = 18556970.87, median_debt_repayment = 12000000 WHERE household_size_code = 'B0603';
UPDATE kosis_household_net_worth SET avg_debt_repayment = 23979991.82, median_debt_repayment = 13400000 WHERE household_size_code = 'B0604';
UPDATE kosis_household_net_worth SET avg_debt_repayment = 22713081.99, median_debt_repayment = 14110000 WHERE household_size_code = 'B0605';
UPDATE kosis_age_group_net_worth SET avg_debt_repayment = 13276190.36, median_debt_repayment = 10060000 WHERE age_group_code = 'B1600';
UPDATE kosis_age_group_net_worth SET avg_debt_repayment = 9021909.10, median_debt_repayment = 5700000 WHERE age_group_code = 'B1601';
UPDATE kosis_age_group_net_worth SET avg_debt_repayment = 16457212.87, median_debt_repayment = 9840000 WHERE age_group_code = 'B1602';
UPDATE kosis_age_group_net_worth SET avg_debt_repayment = 21337541.47, median_debt_repayment = 13000000 WHERE age_group_code = 'B1603';
UPDATE kosis_age_group_net_worth SET avg_debt_repayment = 15839525.08, median_debt_repayment = 10400000 WHERE age_group_code = 'B1604';
UPDATE kosis_age_group_net_worth SET avg_debt_repayment = 7470540.15, median_debt_repayment = 8000000 WHERE age_group_code = 'B1605';

-- [012] FutureSim 계산 가정값
CREATE TABLE app_config (
    config_key VARCHAR(100) NOT NULL COMMENT '설정 키',
    config_value VARCHAR(200) NOT NULL COMMENT '설정 값(문자열로 저장, 필요 시 각 서비스에서 파싱)',
    description VARCHAR(300) NULL COMMENT '설정값 설명 및 출처',
    PRIMARY KEY (config_key)
) COMMENT='애플리케이션 전역 설정값(키-값)';
INSERT INTO app_config (config_key, config_value, description) VALUES
('FUTURESIM_ASSUMED_RETURN_RATE', '3.08', '여유자금 평균 수익률 가정(연%) - 한국은행 저축성수신금리, 2026.06 기준'),
('FUTURESIM_RATE_RISK_THRESHOLD_MULTIPLIER', '1.2', '4단계 금리 리스크 참고 카드 - 월상환액이 현재 대비 이 배수를 넘으면 "부담 임계 도달"로 판단(기본 20% 증가)');


  CREATE TABLE report_card_layout (
      id            BIGINT       NOT NULL AUTO_INCREMENT,
      user_id       BIGINT       NOT NULL,
      card_key      VARCHAR(30)  NOT NULL,
      ref_id        BIGINT       NULL COMMENT '카드가 참조하는 대상 id (예: 미래 시뮬레이터 저장 계획 id)',
      display_order INT          NOT NULL,
      created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (id),
      KEY idx_report_card_layout_user (user_id, display_order),
      CONSTRAINT fk_report_card_layout_user
          FOREIGN KEY (user_id) REFERENCES app_user (user_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
  COMMENT='개인화 리포트 카드 배치(사용자별 선택 카드와 표시 순서)';

  INSERT INTO app_config (config_key, config_value, description) VALUES
  ('REPORT_SCORE_WEIGHT_DSR', '30', '개인화 리포트 종합 점수 - DSR건전성 가중치(%)'),
  ('REPORT_SCORE_WEIGHT_SAVINGS_RATE', '25', '개인화 리포트 종합 점수 - 저축률 가중치(%)'),
  ('REPORT_SCORE_WEIGHT_DEBT_RATIO', '20', '개인화 리포트 종합 점수 - 부채비율 가중치(%)'),
  ('REPORT_SCORE_WEIGHT_VULNERABILITY', '15', '개인화 리포트 종합 점수 - 취약도역산 가중치(%)'),
  ('REPORT_SCORE_WEIGHT_SPENDING_STABILITY', '10', '개인화 리포트 종합 점수 - 소비안정성 가중치(%)');
  
  
  DROP TABLE IF EXISTS futuresim_plan_snapshot;

  CREATE TABLE futuresim_plan_snapshot (
      id                        BIGINT        NOT NULL AUTO_INCREMENT,
      user_id                   BIGINT        NOT NULL COMMENT '회원 (FK)',
      plan_name                 VARCHAR(50)   NOT NULL,
      goal_amount               DECIMAL(19,2) NOT NULL,
      goal_preset_key           VARCHAR(30)   NULL,

      benchmark_type            VARCHAR(20)   NULL COMMENT 'AGE 또는 HOUSEHOLD, 없으면 NULL',
      benchmark_label           VARCHAR(20)   NULL,
      benchmark_median_net_worth DECIMAL(19,2) NULL,

      assumed_return_rate       DECIMAL(6,3)  NOT NULL DEFAULT 3.080,

      selected_levers_json      JSON          NOT NULL,
      loan_impact_json          JSON          NULL,

      baseline_months_to_goal   INT           NOT NULL,
      projected_months_to_goal  INT           NOT NULL,
      diff_months               INT           NOT NULL DEFAULT 0,
      final_net_worth           DECIMAL(19,2) NOT NULL,

      updated_at                DATETIME      NOT NULL
                                DEFAULT CURRENT_TIMESTAMP
                                ON UPDATE CURRENT_TIMESTAMP,

      PRIMARY KEY (id),
      UNIQUE KEY uk_user_plan_name (user_id, plan_name),

      CONSTRAINT fk_futuresim_plan_user
          FOREIGN KEY (user_id)
          REFERENCES app_user (user_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
  COMMENT='미래 금융 시뮬레이터 저장 실행계획 스냅샷';
  
  
    CREATE TABLE financial_institution (                                                                                                                                   
      institution_id BIGINT PRIMARY KEY AUTO_INCREMENT,                                                                                                                  
      org_code VARCHAR(10) NOT NULL,                                                                                                                                     
      institution_name VARCHAR(100) NOT NULL,  
      institution_type VARCHAR(20) NOT NULL,                                                                                                                        
      UNIQUE KEY uk_financial_institution_org_code (org_code)                                                                                                            
  );                                                                                                                                                                     



CREATE TABLE `card_account` (
  `card_account_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `institution_id` bigint NOT NULL,
  `connection_id` bigint NOT NULL,
  `external_card_key` varchar(100) NOT NULL,
  `card_name` varchar(100) NOT NULL,
  `card_number_masked` varchar(50) NOT NULL,
  `payment_day` int DEFAULT NULL,
  `issued_at` date DEFAULT NULL,
  `data_as_of_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`card_account_id`),
  KEY `fk_card_account_app_user` (`user_id`),
  KEY `fk_card_account_institution` (`institution_id`),
  KEY `fk_card_account_mydata_connection` (`connection_id`),
  KEY `idx_card_account_external_card_key` (`external_card_key`),
  CONSTRAINT `fk_card_account_app_user` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`user_id`),
  CONSTRAINT `fk_card_account_institution` FOREIGN KEY (`institution_id`) REFERENCES `financial_institution` (`institution_id`),
  CONSTRAINT `fk_card_account_mydata_connection` FOREIGN KEY (`connection_id`) REFERENCES `mydata_connection` (`connection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `card_transaction` (
  `card_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `card_account_id` bigint NOT NULL,
  `external_transaction_id` varchar(100) NOT NULL,
  `transaction_at` datetime NOT NULL,
  `amount` decimal(19,2) NOT NULL,
  `merchant_name` varchar(150) NOT NULL,
  PRIMARY KEY (`card_transaction_id`),
  UNIQUE KEY `uk_card_transaction_account_external` (`card_account_id`, `external_transaction_id`),
  CONSTRAINT `fk_card_transaction_card_account` FOREIGN KEY (`card_account_id`) REFERENCES `card_account` (`card_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE card_bill (
    card_bill_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT NOT NULL,
    connection_id BIGINT NOT NULL,

    seqno VARCHAR(50) NOT NULL,
    charge_amount DECIMAL(19,2) NOT NULL DEFAULT 0,
    charge_day VARCHAR(10),
    charge_month VARCHAR(6),
    paid_out_date DATE NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY uk_card_bill (
        connection_id,
        seqno,
        charge_month
    ),

    KEY idx_card_bill_user_month (
        user_id,
        charge_month
    ),

    CONSTRAINT fk_card_bill_user
        FOREIGN KEY (user_id)
        REFERENCES app_user(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_card_bill_connection
        FOREIGN KEY (connection_id)
        REFERENCES mydata_connection(connection_id)
        ON DELETE CASCADE
);


CREATE TABLE account
(
    account_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    external_account_key VARCHAR(100) NOT NULL,

    account_type VARCHAR(30) NULL,

    account_name VARCHAR(100) NULL,

    current_balance DECIMAL(19,2) NULL,

    account_status VARCHAR(20) NULL,

    opened_at DATE NULL,

    maturity_at DATE NULL,

    data_as_of_at DATETIME NULL,

    updated_at DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    connection_id BIGINT NOT NULL,

    org_code VARCHAR(10) NOT NULL,

    CONSTRAINT fk_account_connection
        FOREIGN KEY (connection_id)
        REFERENCES mydata_connection (connection_id)
        ON DELETE CASCADE,

    CONSTRAINT uk_account_external_key
        UNIQUE (connection_id, external_account_key)
);



CREATE TABLE account_transaction
(
    transaction_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    account_id BIGINT NOT NULL,

    external_transaction_id VARCHAR(100) NULL,

    transaction_at DATETIME NULL,

    transaction_type VARCHAR(30) NULL,

    amount DECIMAL(19,2) NULL,

    balance_after DECIMAL(19,2) NULL,

    merchant_name VARCHAR(150) NULL,

    description VARCHAR(300) NULL,

    category_code VARCHAR(50) NOT NULL,

    CONSTRAINT fk_account_transaction_account
        FOREIGN KEY (account_id)
        REFERENCES account (account_id)
        ON DELETE CASCADE
);