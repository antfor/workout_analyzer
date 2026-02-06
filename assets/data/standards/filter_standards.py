
import csv
import os

def filter_standards():
    # Paths
    base_dir = os.path.dirname(os.path.abspath(__file__))
    map_file = os.path.join(base_dir, '../map/mapLimited.csv')
    output_dir = os.path.join(base_dir, 'limited')

    # Create output directory
    os.makedirs(output_dir, exist_ok=True)

    # 1. Read allowed standards
    allowed_standards = set()
    try:
        with open(map_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            # The column name in mapLimited.csv is 'Strandards' (typo)
            # We need to handle potential whitespace trimming
            for row in reader:
                if 'Strandards' in row:
                    val = row['Strandards'].strip()
                    if val:
                        allowed_standards.add(val)
                # Fallback if typo is fixed or mapping is different 
                elif 'Standards' in row:
                    val = row['Standards'].strip()
                    if val:
                        allowed_standards.add(val)
    except FileNotFoundError:
        print(f"Error: Could not find map file at {map_file}")
        return

    print(f"Loaded {len(allowed_standards)} allowed standards.")

    # 2. Process CSV files in the current directory
    for filename in os.listdir(base_dir):
        if not filename.endswith('.csv') or filename == 'filter_standards.py':
            continue
            
        file_path = os.path.join(base_dir, filename)
        
        # Skip if it's a directory
        if os.path.isdir(file_path):
            continue

        print(f"Processing {filename}...")

        try:
            with open(file_path, 'r', encoding='utf-8') as f_in:
                # Read header to check for "Exercise" column
                # Using csv.reader first to handle potential BOM or weird formats gracefully, 
                # but DictReader is easier for column access.
                # Let's peek at the header.
                header_line = f_in.readline()
                f_in.seek(0)
                
                if not header_line:
                    print(f"  Skipping empty file: {filename}")
                    continue
                
                reader = csv.DictReader(f_in)
                fieldnames = reader.fieldnames
                
                if not fieldnames or 'Exercise' not in fieldnames:
                    print(f"  Skipping {filename}: No 'Exercise' column found.")
                    continue
                
                # Filter rows
                filtered_rows = []
                for row in reader:
                    exercise = row.get('Exercise', '').strip()
                    if exercise in allowed_standards:
                        filtered_rows.append(row)
                
                # Write to output file
                output_path = os.path.join(output_dir, filename)
                with open(output_path, 'w', encoding='utf-8', newline='') as f_out:
                    writer = csv.DictWriter(f_out, fieldnames=fieldnames, lineterminator='\n')
                    writer.writeheader()
                    writer.writerows(filtered_rows)
                
                print(f"  Saved {len(filtered_rows)} rows to {output_path}")

        except Exception as e:
            print(f"  Error processing {filename}: {e}")

if __name__ == "__main__":
    filter_standards()
