#!/usr/bin/env python3
"""Generate simple developer-themed icons"""

def create_simple_png(filename, size, color_hex):
    """Create a simple colored square PNG with a code symbol"""
    # PNG header and basic structure
    width = height = size
    
    # Convert hex color to RGB
    color = tuple(int(color_hex[i:i+2], 16) for i in (0, 2, 4))
    
    # Create a simple PNG with a colored background
    # This is a minimal approach without PIL
    import struct
    
    def png_pack(png_tag, data):
        chunk_head = png_tag
        return (struct.pack("!I", len(data)) +
                chunk_head +
                data +
                struct.pack("!I", 0xFFFFFFFF & zlib.crc32(chunk_head + data)))
    
    import zlib
    
    # Create raw image data - solid color with dark code brackets
    raw_data = bytearray()
    bracket_color = (255, 255, 255)  # White brackets
    
    # Draw a simple "</>" pattern
    for y in range(height):
        row = bytearray([0])  # Filter type
        for x in range(width):
            # Simple bracket pattern in center
            is_bracket = False
            cx, cy = width // 2, height // 2
            
            # Left bracket "<"
            if 20 < x < 40 and abs(y - cy) < 3:
                is_bracket = True
            elif 20 < x < 23 and cy - 20 < y < cy + 20:
                is_bracket = True
            
            # Right bracket ">"
            elif width - 40 < x < width - 20 and abs(y - cy) < 3:
                is_bracket = True
            elif width - 23 < x < width - 20 and cy - 20 < y < cy + 20:
                is_bracket = True
                
            # Forward slash "/"
            elif cx - 5 < x < cx + 5:
                slope_y = cy - (x - cx) * 2
                if abs(y - slope_y) < 3:
                    is_bracket = True
            
            if is_bracket:
                row.extend(bracket_color)
            else:
                row.extend(color)
            row.append(255)  # Alpha
        raw_data.extend(row)
    
    compressed = zlib.compress(bytes(raw_data), 9)
    
    png_data = (b'\x89PNG\r\n\x1a\n' +
                png_pack(b'IHDR', struct.pack("!2I5B", width, height, 8, 6, 0, 0, 0)) +
                png_pack(b'IDAT', compressed) +
                png_pack(b'IEND', b''))
    
    with open(filename, 'wb') as f:
        f.write(png_data)
    print(f"Created {filename}")

# Generate dev-themed icons with dark blue background
create_simple_png('web/icons/Icon-192.png', 192, '16213e')
create_simple_png('web/icons/Icon-512.png', 512, '16213e')
create_simple_png('web/icons/Icon-maskable-192.png', 192, '1a1a2e')
create_simple_png('web/icons/Icon-maskable-512.png', 512, '1a1a2e')

print("Dev-themed icons created successfully!")
