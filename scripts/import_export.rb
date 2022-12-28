def save_result_as_csv(data, file_path)
  csv_data = CSV.generate(col_sep: "\t") do |csv|
    csv << data.first.keys.map(&:upcase)
    data.each { |element| csv << element.values }
  end

  File.open(file_path, 'w') { |file| file.write(csv_data) }
end

def save_as_nmap_targets(data, dst_dir)
  ipv4_addr = data.reject { |x| x[:ip_type] == 'bogon' }.map { |x| x[:ip_addr] }.select { |x| x.match(Resolv::IPv4::Regex) }
  ipv6_addr = data.reject { |x| x[:ip_type] == 'bogon' }.map { |x| x[:ip_addr] }.select { |x| x.match(Resolv::IPv6::Regex) }
  File.open("#{dst_dir}/nmap_ipv4_targets.txt", 'w') { |f| f.write(ipv4_addr.join("\n")) }
  File.open("#{dst_dir}/nmap_ipv6_targets.txt", 'w') { |f| f.write(ipv6_addr.join("\n")) }
end
