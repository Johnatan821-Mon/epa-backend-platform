-- ============================================
-- Product Purchasing System - Initial Data
-- ============================================
--
-- Este script inserta datos iniciales para testing y desarrollo.
--
-- Para ejecutar:
-- psql -U user_pps -d pps_db -f data.sql
-- ============================================

-- ============================================
-- Datos: roles
-- ============================================
INSERT INTO roles (role_id, name, description) VALUES
(1, 'ADMIN', 'Administrator with full access'),
(2, 'CUSTOMER', 'Regular customer user'),
(3, 'MANAGER', 'Store manager with elevated privileges')
ON CONFLICT (role_id) DO UPDATE SET description = EXCLUDED.description;

-- ============================================
-- Datos: order_statuses
-- ============================================
INSERT INTO order_statuses (order_status_id, name, description) VALUES
(1, 'PENDING', 'Order created, awaiting payment'),
(2, 'CONFIRMED', 'Payment confirmed, processing order'),
(3, 'PROCESSING', 'Order is being prepared'),
(4, 'SHIPPED', 'Order has been shipped'),
(5, 'DELIVERED', 'Order delivered successfully'),
(6, 'CANCELLED', 'Order was cancelled'),
(7, 'REFUNDED', 'Order was refunded')
ON CONFLICT (order_status_id) DO UPDATE SET description = EXCLUDED.description;

-- ============================================
-- Datos: payment_methods
-- ============================================
INSERT INTO payment_methods (payment_method_id, name, description) VALUES
(1, 'CREDIT_CARD', 'Credit Card Payment'),
(2, 'DEBIT_CARD', 'Debit Card Payment'),
(3, 'PAYPAL', 'PayPal Payment'),
(4, 'BANK_TRANSFER', 'Bank Transfer'),
(5, 'CASH_ON_DELIVERY', 'Cash on Delivery')
ON CONFLICT (payment_method_id) DO UPDATE SET description = EXCLUDED.description;

-- ============================================
-- Datos: payment_statuses
-- ============================================
INSERT INTO payment_statuses (payment_status_id, name, description) VALUES
(1, 'PENDING', 'Payment pending'),
(2, 'PROCESSING', 'Payment being processed'),
(3, 'COMPLETED', 'Payment completed successfully'),
(4, 'FAILED', 'Payment failed'),
(5, 'REFUNDED', 'Payment refunded'),
(6, 'CANCELLED', 'Payment cancelled')
ON CONFLICT (payment_status_id) DO UPDATE SET description = EXCLUDED.description;

-- ============================================
-- Datos: categories (EPA - Empresa Proveedora de Alimentos)
-- ============================================
-- Se conservan los IDs originales y solo cambia el rotulo, para no romper
-- las filas de products que ya apuntan a estas categorias.
-- Categorías raíz
INSERT INTO categories (category_id, parent_id, name, slug) VALUES
(1, NULL, 'Despensa', 'despensa'),
(2, NULL, 'Aseo del hogar', 'aseo-del-hogar'),
(3, NULL, 'Cuidado personal', 'cuidado-personal'),
(4, NULL, 'Bebidas', 'bebidas')
ON CONFLICT (category_id) DO UPDATE SET name = EXCLUDED.name, slug = EXCLUDED.slug, parent_id = EXCLUDED.parent_id;

-- Subcategorías de Despensa
INSERT INTO categories (category_id, parent_id, name, slug) VALUES
(11, 1, 'Granos y pastas', 'granos-y-pastas'),
(12, 1, 'Aceites y salsas', 'aceites-y-salsas'),
(13, 1, 'Lácteos', 'lacteos'),
(14, 1, 'Snacks y confitería', 'snacks-y-confiteria')
ON CONFLICT (category_id) DO UPDATE SET name = EXCLUDED.name, slug = EXCLUDED.slug, parent_id = EXCLUDED.parent_id;

-- Subcategorías de Aseo del hogar
INSERT INTO categories (category_id, parent_id, name, slug) VALUES
(21, 2, 'Detergentes', 'detergentes'),
(22, 2, 'Limpiadores', 'limpiadores'),
(23, 2, 'Cuidado del bebé', 'cuidado-del-bebe')
ON CONFLICT (category_id) DO UPDATE SET name = EXCLUDED.name, slug = EXCLUDED.slug, parent_id = EXCLUDED.parent_id;

-- Subcategorías de Cuidado personal
INSERT INTO categories (category_id, parent_id, name, slug) VALUES
(31, 3, 'Higiene personal', 'higiene-personal'),
(32, 3, 'Mascotas', 'mascotas'),
(33, 3, 'Enlatados', 'enlatados')
ON CONFLICT (category_id) DO UPDATE SET name = EXCLUDED.name, slug = EXCLUDED.slug, parent_id = EXCLUDED.parent_id;

-- ============================================
-- Datos: products (EPA - alimentos y consumo masivo)
-- ============================================
-- Despensa > Granos y pastas
INSERT INTO products (product_id, category_id, sku, name, description, price, stock_qty, is_active, image) VALUES
(1, 11, 'DESP-GRA-001', 'Arroz blanco Zulia 1 kg', '', 4500.00, 200, TRUE, ''),
(2, 11, 'DESP-GRA-002', 'Fríjol cargamanto Granipack 500 g', '', 8900.00, 120, TRUE, ''),
(3, 11, 'DESP-GRA-003', 'Pasta espagueti Jirafa 500 g', '', 3200.00, 150, TRUE, '')
ON CONFLICT (product_id) DO UPDATE SET category_id = EXCLUDED.category_id, sku = EXCLUDED.sku, name = EXCLUDED.name, description = EXCLUDED.description, price = EXCLUDED.price, stock_qty = EXCLUDED.stock_qty, image = EXCLUDED.image;

-- Despensa > Aceites y salsas
INSERT INTO products (product_id, category_id, sku, name, description, price, stock_qty, is_active, image) VALUES
(4, 12, 'DESP-SAL-001', 'Salsa de tomate Fruco 380 g', '', 6800.00, 90, TRUE, ''),
(5, 12, 'DESP-SAL-002', 'Margarina Rama 250 g', '', 7500.00, 80, TRUE, ''),
(6, 12, 'DESP-ACE-001', 'Aceite de girasol Gran Cocina 1 L', '', 12900.00, 70, TRUE, '')
ON CONFLICT (product_id) DO UPDATE SET category_id = EXCLUDED.category_id, sku = EXCLUDED.sku, name = EXCLUDED.name, description = EXCLUDED.description, price = EXCLUDED.price, stock_qty = EXCLUDED.stock_qty, image = EXCLUDED.image;

-- Despensa > Lácteos
INSERT INTO products (product_id, category_id, sku, name, description, price, stock_qty, is_active, image) VALUES
(7, 13, 'DESP-LAC-001', 'Leche entera Parmalat 1 L', '', 4200.00, 300, TRUE, ''),
(8, 13, 'DESP-LAC-002', 'Queso campesino Parmalat 500 g', '', 11500.00, 60, TRUE, '')
ON CONFLICT (product_id) DO UPDATE SET category_id = EXCLUDED.category_id, sku = EXCLUDED.sku, name = EXCLUDED.name, description = EXCLUDED.description, price = EXCLUDED.price, stock_qty = EXCLUDED.stock_qty, image = EXCLUDED.image;

-- Despensa > Snacks y confitería
INSERT INTO products (product_id, category_id, sku, name, description, price, stock_qty, is_active, image) VALUES
(9, 14, 'DESP-CON-001', 'Gomas surtidas Aldor 100 g', '', 2500.00, 250, TRUE, ''),
(10, 14, 'DESP-CON-002', 'Chocolatinas Aldor 12 und', '', 3800.00, 180, TRUE, '')
ON CONFLICT (product_id) DO UPDATE SET category_id = EXCLUDED.category_id, sku = EXCLUDED.sku, name = EXCLUDED.name, description = EXCLUDED.description, price = EXCLUDED.price, stock_qty = EXCLUDED.stock_qty, image = EXCLUDED.image;

-- Aseo del hogar
INSERT INTO products (product_id, category_id, sku, name, description, price, stock_qty, is_active, image) VALUES
(11, 21, 'HOGA-DET-001', 'Detergente en polvo Henkel 2 kg', '', 15900.00, 100, TRUE, ''),
(12, 22, 'HOGA-LIM-001', 'Limpiador multiusos Zafey 1 L', '', 8400.00, 110, TRUE, '')
ON CONFLICT (product_id) DO UPDATE SET category_id = EXCLUDED.category_id, sku = EXCLUDED.sku, name = EXCLUDED.name, description = EXCLUDED.description, price = EXCLUDED.price, stock_qty = EXCLUDED.stock_qty, image = EXCLUDED.image;

-- Cuidado personal
INSERT INTO products (product_id, category_id, sku, name, description, price, stock_qty, is_active, image) VALUES
(13, 31, 'PERS-HIG-001', 'Jabón de tocador Dove 90 g', '', 5900.00, 200, TRUE, ''),
(22, 32, 'PERS-MAS-001', 'Alimento para perro Solla 2 kg', '', 45000.00, 40, TRUE, ''),
(23, 33, 'PERS-ENL-001', 'Atún en lomitos Agronat 160 g', '', 6200.00, 140, TRUE, '')
ON CONFLICT (product_id) DO UPDATE SET category_id = EXCLUDED.category_id, sku = EXCLUDED.sku, name = EXCLUDED.name, description = EXCLUDED.description, price = EXCLUDED.price, stock_qty = EXCLUDED.stock_qty, image = EXCLUDED.image;

-- Bebidas
INSERT INTO products (product_id, category_id, sku, name, description, price, stock_qty, is_active, image) VALUES
(21, 4, 'BEBI-INF-001', 'Té Lipton limón 20 sobres', '', 9800.00, 130, TRUE, '')
ON CONFLICT (product_id) DO UPDATE SET category_id = EXCLUDED.category_id, sku = EXCLUDED.sku, name = EXCLUDED.name, description = EXCLUDED.description, price = EXCLUDED.price, stock_qty = EXCLUDED.stock_qty, image = EXCLUDED.image;

-- ============================================
-- Datos: users (Ejemplos para testing)
-- ============================================
-- NOTA: Los password_hash aquí son placeholders temporales.
-- DataInitializerConfig los reemplaza con hashes BCrypt reales al arrancar.
-- Contraseñas de desarrollo:
--   admin@pps.com      -> admin123
--   john.doe@email.com -> customer123
--   jane.smith@email.com -> customer123
--   manager@pps.com    -> manager123
INSERT INTO users (user_id, role_id, email, password_hash, first_name, last_name, phone, status) VALUES
(1, 1, 'admin@pps.com', 'PLACEHOLDER', 'Admin', 'User', '555-0001', 'ACTIVE'),
(2, 2, 'john.doe@email.com', 'PLACEHOLDER', 'John', 'Doe', '555-0100', 'ACTIVE'),
(3, 2, 'jane.smith@email.com', 'PLACEHOLDER', 'Jane', 'Smith', '555-0101', 'ACTIVE'),
(4, 3, 'manager@pps.com', 'PLACEHOLDER', 'Store', 'Manager', '555-0002', 'ACTIVE')
ON CONFLICT (user_id) DO UPDATE SET email = EXCLUDED.email;

-- ============================================
-- Datos: addresses (Ejemplos)
-- ============================================
-- NOTA: no hay una clave única sobre (user_id, type) en el esquema, así que
-- no se puede hacer upsert real; se inserta solo si el usuario aún no tiene
-- direcciones (misma limitación que tenía la versión MySQL, donde el
-- ON DUPLICATE KEY UPDATE tampoco encontraba una clave contra la que chocar).
INSERT INTO addresses (user_id, type, line1, line2, city, state, country, postal_code, is_default)
SELECT 2, 'SHIPPING', '123 Main Street', 'Apt 4B', 'New York', 'NY', 'USA', '10001', TRUE
WHERE NOT EXISTS (SELECT 1 FROM addresses WHERE user_id = 2 AND type = 'SHIPPING');

INSERT INTO addresses (user_id, type, line1, line2, city, state, country, postal_code, is_default)
SELECT 2, 'BILLING', '123 Main Street', 'Apt 4B', 'New York', 'NY', 'USA', '10001', TRUE
WHERE NOT EXISTS (SELECT 1 FROM addresses WHERE user_id = 2 AND type = 'BILLING');

INSERT INTO addresses (user_id, type, line1, line2, city, state, country, postal_code, is_default)
SELECT 3, 'SHIPPING', '456 Oak Avenue', NULL, 'Los Angeles', 'CA', 'USA', '90001', TRUE
WHERE NOT EXISTS (SELECT 1 FROM addresses WHERE user_id = 3 AND type = 'SHIPPING');

INSERT INTO addresses (user_id, type, line1, line2, city, state, country, postal_code, is_default)
SELECT 3, 'BILLING', '456 Oak Avenue', NULL, 'Los Angeles', 'CA', 'USA', '90001', TRUE
WHERE NOT EXISTS (SELECT 1 FROM addresses WHERE user_id = 3 AND type = 'BILLING');

-- ============================================
-- Verificación de datos insertados
-- ============================================
-- SELECT * FROM roles;
-- SELECT * FROM categories WHERE parent_id IS NULL;
-- SELECT * FROM products LIMIT 5;
-- SELECT * FROM users;
