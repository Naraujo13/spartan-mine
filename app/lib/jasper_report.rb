#!/bin/env ruby
# encoding: UTF-8
require "net/http"
require 'digest/md5'

class JasperReport
  
    
    def initialize(file_name='file name', report_name='athome/example', params_report = nil, output='pdf',address_url = 'http://localhost',port_url = '8080', j_username='jasperadmin', j_password='jasperadmin')
        @address_url      = address_url
        @port_url         = port_url
        @model            = report_name # Logical path on Jasper Report Server '/reports/cientum_curriculum'
        @report_params    = params_report
        @user_name        = j_username
        @user_password    = j_password
        @format_output    = output
        @file_name        = file_name
        
        # A url example
        #   #http://localhost:8080/jasperserver/flow.html?_flowId=viewReportFlow&reportUnit=/reports/cientum_curriculum&param1=value1&param2=value2&j_username=jasperadmin&j_password=jasperadmin&&output=pdf
        
        #make the url to require the file
        @url = @address_url+":"+@port_url+"/jasperserver/flow.html?_flowId=viewReportFlow&reportUnit=/"+@model
        if @report_params != nil
            @url+="&"+@report_params
        end
        @url+="&j_username="+@user_name+"&j_password="+@user_password+"&output="+@format_output
        Rails.logger.info 'URL report'
        Rails.logger.info @url
    end
    
    def get_report
        @data       = {}
        file_jasper = nil
        
        @file_name  = @file_name.downcase
        @file_name  = @file_name.gsub(' ', '_')
        @file_name += "_#{Time.now.year}#{Time.now.month}#{Time.now.day}#{Time.now.hour}#{Time.now.min}#{Time.now.sec}"
        @file_name_on_server = Digest::MD5.hexdigest(@file_name)
        
        begin
            file_jasper = open('public/data/' + @file_name_on_server + '.'+@format_output, 'wb') do |file|
                file << open(@url).read
            end
            @data['success']    = true
            @data['file']       = "/data/"+@file_name_on_server+'.'+@format_output
            @data['file_name']  = @file_name+'.'+@format_output
            #@data['message']    = ''
        rescue => e
            @data['success']    = false
            @data['file']       = ''
            @data['file_name']  = ''
            #@data['message']    = e.message
        end
        
        return @data
        
    end
    
    #check if Jasper Report Server is on Air
    #def check_server(server, port)
    #    begin
    #        http = Net::HTTP.start(server, port, {open_timeout: 5, read_timeout: 5})
    #        begin
    #            response = http.head("/")
    #            if response.code == "200"
                # everything fine
    #            else
                # unexpected status code
    #            end
    #        rescue Timeout::Error
              # timeout reading from server
    #        end
    #        rescue Timeout::Error
            # timeout connecting to server
    #        rescue SocketError
            # unknown server
    #    end
    #end
end